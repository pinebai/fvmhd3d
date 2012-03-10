
set uniq=0
if ( "$1" == '-1' ) then
 set uniq=1
 shift
endif

if ($# == 0) then
#  echo "[Usage] $0  machinefile > nodelistfile"
#  exit (1)
 setenv mfile $PBS_NODEFILE
else
 setenv mfile $1
endif

printf 'group main ++shell \"/usr/bin/ssh -q -o
UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o
CheckHostIP=no -o BatchMode=yes\"\n'

if ( $uniq == 0 ) then
set nodes=`grep -v '^#' $mfile | awk -F: '{ print $1; if (NF==2) for
(i=1;i<$2; i++) print $1; }'`
else
set nodes=`grep -v '^#' $mfile | uniq | awk -F: '{ print $1; }'`
endif
foreach node ($nodes)
 printf "host $node\n"
end
