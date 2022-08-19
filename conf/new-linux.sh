#!/bin/bash
# $1 argument is home directory

NO_ARGS=0
E_OPTERROR=1

default_username="test"
homedir="/home/$default_username"
scriptdir=$(dirname "$0")
workdir=$(readlink -f .)

get_help() 
{
  echo "Использование: `basename $0` -acdhiu [USERNAME]"
  echo " -a USERNAME  выполнить все операции"
  echo " -c USERNAME  обновить конфиги"
  echo " -d   скачать conf"
  echo " -h   порядок использования"
  echo " -i   установить wget"
  echo " -u USERNAME  создать пользователя" 

}


if [ $# -eq "$NO_ARGS" ]  # Сценарий вызван без аргументов?
then
  get_help
  exit $E_OPTERROR        # Если аргументы отсутствуют -- выход с сообщением
                          # о порядке использования скрипта
fi

# Все опции отключены по умолчанию
opt_c=0; opt_d=0; opt_i=0; opt_u=0;

while getopts "a:bc:dhiu:" Option
do
  case $Option in 
    a ) opt_c=1; opt_d=1; opt_i=1; opt_u=1; 
        opt_u_arg="$OPTARG"
        homedir="/home/$opt_u_arg"
        ;;
    c ) opt_c=1
        opt_u_arg="$OPTARG"
        homedir="/home/$opt_u_arg"
        ;;
    d ) opt_d=1;;
    i ) opt_i=1;;
    u ) opt_u=1; 
        opt_u_arg="$OPTARG"
        homedir="/home/$opt_u_arg"
        ;;
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
  wget -q https://ilych.github.io/files/conf.tgz || { echo "Error while download conf.tgz" >&2; exit 3; } 

fi

 
if [ "$opt_c" == "1" ]
then
  echo "Updating rc files"
  # cd "$homedir" || { echo "Can't enter to '$homedir'" 1>&2; exit 1; }
  [ -w "$homedir" ] || { echo "Directory '$homedir' is not writable" >&2; exit 4; } 
  [ -r "$workdir/conf.tgz" ] || { echo "File '$workdir/conf.tgz' is not readable" >&2; exit 4; } 
  echo "Unpacking '$workdir/conf.tgz' to '$homedir'"
  tar -xf "$workdir/conf.tgz" -C "$homedir"
  bash "$scriptdir/set-user.sh" "$homedir" 
  # cd "$workdir" || { echo "Can't enter to '$workdir'" 1>&2; exit 1; } 
fi




exit 0
