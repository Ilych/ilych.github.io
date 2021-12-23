#!/bin/bash

get_help() 
{
  echo "Использование: `basename $0` -acdiu"
  echo " -a   выполнить все операции"
  echo " -c   не обновлять конфиги"
  echo " -d   не скачивать conf"
  echo " -h   порядок использования"
  echo " -i   не устанавливать wget"
  echo " -u   не создавать пользователя" 

}

NO_ARGS=0

if [ $# -eq "$NO_ARGS" ]  # Сценарий вызван без аргументов?
then
  get_help
  exit $E_OPTERROR        # Если аргументы отсутствуют -- выход с сообщением
                          # о порядке использования скрипта
fi



# Все опции включены по умолчанию
opt_c=1; opt_d=1; opt_i=1; opt_u=1; opt_h=0;

while getopts "acdhiu" Option
do
  case $Option in 
    a ) ;;
    c ) opt_c=0;;
    d ) opt_d=0;;
    i ) opt_i=0;;
    u ) opt_u=0;;
    h ) opt_h=1;;
  esac
done

if [ "$opt_h" -eq "1" ]
then

  get_help
fi

