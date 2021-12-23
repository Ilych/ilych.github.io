#!/bin/bash
# $1 argument is home directory

NO_ARGS=0
E_OPTERROR=1

# username="homer"
homedir="/home/$username"
scriptdir=$(dirname "$0")
workdir=$(readlink -f .)

get_help() 
{
  echo "Использование: `basename $0` -acdhiu [USERNAME]"
  echo " -a   выполнить все операции"
  echo " -c   обновить конфиги"
  echo " -d   скачать conf"
  echo " -h   порядок использования"
  echo " -i   установить wget"
  echo " -u   создать пользователя" 

}


if [ $# -eq "$NO_ARGS" ]  # Сценарий вызван без аргументов?
then
  get_help
  exit $E_OPTERROR        # Если аргументы отсутствуют -- выход с сообщением
                          # о порядке использования скрипта
fi

# Все опции включены по умолчанию
# opt_c=1; opt_d=1; opt_i=1; opt_u=1;

while getopts "acdhiu:" Option
do
  case $Option in 
    a ) opt_c=1; opt_d=1; opt_i=1; opt_u=1;;
    c ) opt_c=0;;
    d ) opt_d=0;;
    i ) opt_i=0;;
    u ) opt_u=0; opt_u_arg="$OPTARG";;
    h ) opt_h=1;;
  esac
done

if [ "$opt_h" == "1" ]
then
  get_help
  exit 0
fi


if [ "$opt_u" == "1" ]
then
  echo "Performing useradd"
  useradd -m -s /bin/bash "$opt_u_arg"
  chmod 750 "$homedir"
  chmod -R o-rx "$homedir"
fi

if [ "$opt_i" == "1" ]
then
  echo "Installing wget"
  DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends wget || { echo "Error while install wget" >&2; exit 2; }
fi


if [ "$opt_d" == "1" ]
then
  echo "Downloading conf.tgz"
  cd "$homedir" || { echo "Can't enter to /home/nik" 1>&2; exit 1; }
  wget https://ilych.github.io/conf.tgz || { echo "Error while download conf.tgz" >&2; exit 3; } 
  tar -xvf "$homedir/conf.tgz"
  cd "$workdir"

fi

 
if [ "$opt_d" == "1" ]
then
  echo "Updating dot files"
  bash "$scriptdir/set-user.sh" "$homedir" 
fi




exit 0
