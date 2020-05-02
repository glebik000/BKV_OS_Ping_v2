# BKV_OS_Ping_v2
Tasks:
Усложняем ping.
Работаем с файлом /etc/passwd.

(0) Сгенерировать ключ шифрования при помощи ssh-keygen.
    Это должно быть уже сделано.
(1) Написать на bash скрипт, выполняющий следующие действия (2-5):
(2) Получить список включенных компьютеров из диапазона IP-адресов
     10.40.14.101 - 10.40.14.114 при помощи команды  ping;
(3) разослать ключи шифрования всем включенным хостам при
     помощи команды ssh-copy-id. Убедиться, что у Вас появился
     безпарольный вход на удаленный компьютер.
(4) Создать в своем домашнем каталоге подкаталоги с именами
     последнего октета включенных хостов, т.е. 101, 102, 104 и т.д.
(5) Скопировать в них файлы /etc/passwd с соответствующих хостов.
     Разместить в них список файлов из каталога /home соответствующего
     хоста с полной информацией, т.е. вывод команды ls -al /home/ .
     Для копирования использовать команду scp. Так как у Вас
     вход по ключу, а не по паролю, вводить пароли при выполнении
     скрипта не нужно будет. Только при копировании ключей.

  Второй скрипт должен работать с информацией, расположенной в
  каталогах 101, 102, ... 114.
  Он должен выполнить анализ находящихся там файлов и получить:

1) Список пользователей, имеющих право безпарольного входа в систему
    с указанием IP адреса и логина пользователя. Такой пользователь
    имеет второе  пустое поле в его записи в файле passwd.
    При просмотре списка пользователей игнорировать системные учетные
    записи, у которых UID (третье поле записи) меньше 1000 или больше 65000.
    
   Вот назначение всех полей, разделенных двоеточием:
    1  login
    2  заход в систему: * или х - с паролем, нет - без пароля
    3  UID
    4  GID
    5  комментарий, может быть ФИО и т.п.
    6  домашний каталог пользователя
    7  оболочка по умолчанию.

2) Список "двойников", пользователей имеющих две учетные записи,
    отличающиеся в логинах наличием символа подчерк _ между инициалами.

3) Список пользователей, имеющих логины не на всех включенных компьютерах,
    указать логин и список хостов, на которых нет учетной записи.

4) Список пользователей, которые ни на одном из включенных компьютеров
    не входили в систему позже 1 января 2016 года. Датой захода считать время
    последнего изменения домашнего каталога пользователя.

Придется выяснить:
- Найти как сравнивать даты.
- Как работать с массивами в bash.
- Как при помощи ssh выполнить команду на удаленном хосте, а
- результат записать в файл на своем компьютере.
- Как сделать парсинг строки passwd при помощи cut.
- Как сделать парсинг строки вывода команды ls -la.
