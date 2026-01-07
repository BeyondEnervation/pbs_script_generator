#!/bin/bash/
num_hours=7
num_threads=40
ram_gb=64
inp_x2m_file_name="NEW_TEST_3x3_SAAF_mox_fis_iga_rse_1.x2m"
filename=$1
echo '#!/bin/bash' >$filename
echo "#PBS -l walltime=0${num_hours}:00:00" >>$filename
echo "#PBS -l select=1:ncpus=${num_threads}:mem=${ram_gb}gb" >>$filename
echo 'cd $PBS_O_WORKDIR' >>$filename
echo 'echo "IN $PBS_O_WORKDIR"' >>$filename
echo 'cd ..' >>$filename
echo "OMP_NUM_THREADS=${num_threads}" >>$filename
echo 'export OMP_NUM_THREADS' >>$filename
echo "./rReignite $inp_x2m_file_name" >>$filename
