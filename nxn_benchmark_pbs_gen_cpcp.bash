#!/bin/bash/
## Check one argument is given and print guide else
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <output_dir_path>"
    exit 1
fi
output_path=$1
## Check this is a directory that exists
if [ ! -d "$output_path" ]; then
    ## Create the directory
    mkdir -p "$output_path"
fi
num_hours=23
num_threads=40
ram_gb=64
for n in $(seq 2 10); do
    ## For files ss_lib_bkup_gen_3x3_SAAF_mox_fis_iga_proc
    ## 9x9_uniform_uox_fis_saaf_iga_sub_4.x2m
    inp_x2m_file_name="${n}x${n}_uniform_uox_fis_font_cp_sub_1.x2m"
    filename="${n}x${n}_cpcp_sub_1_scaling.pbs"
    echo "Making input file: $(basename $filename)"
    file_path=${output_path}/$filename
    echo '#!/bin/bash' >$file_path
    echo "#PBS -l walltime=${num_hours}:59:00" >>$file_path
    echo "#PBS -l select=1:ncpus=${num_threads}:mem=${ram_gb}gb" >>$file_path
    echo 'module load GCC/14.3.0' >>$file_path
    echo 'module load OpenBLAS' >>$file_path
    echo 'cd $PBS_O_WORKDIR' >>$file_path
    echo 'echo "IN $PBS_O_WORKDIR"' >>$file_path
    echo 'cd ..' >>$file_path
    echo "OMP_NUM_THREADS=${num_threads}" >>$file_path
    echo 'export OMP_NUM_THREADS' >>$file_path
    ## Load PETSc inc
    echo 'export PETSC_LIB="/rds/general/user/ljf22/home/installs/petsc-omp-rel/lib/"' >>$file_path
    echo 'export PETSC_INC="/rds/general/user/ljf22/home/installs/petsc-omp-rel/include/"' >>$file_path
    echo "./rReignite $inp_x2m_file_name" >>$file_path
done
