#!/bin/bash

cd ./aobench
echo "$(rm -rf ao objs )"
echo "$(rm -rf ao_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./ao amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./ao_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./deferred
echo "$(rm -rf deferred_shading objs )"
echo "$(rm -rf deferred_shading_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./deferred_shading amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./deferred_shading_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./data/pp1280x720.bin amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./gmres
echo "$(rm -rf gmres objs )"
echo "$(rm -rf gmres_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./gmres amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./gmres_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./mandelbrot
echo "$(rm -rf mandelbrot objs )"
echo "$(rm -rf mandelbrot_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./mandelbrot amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./mandelbrot_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./mandelbrot_tasks
echo "$(rm -rf mandelbrot_tasks objs )"
echo "$(rm -rf mandelbrot_tasks_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./mandelbrot_tasks amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./mandelbrot_tasks_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./noise
echo "$(rm -rf noise objs )"
echo "$(rm -rf noise_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./noise amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./noise_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./options
echo "$(rm -rf options objs )"
echo "$(rm -rf options_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./options amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./options_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./perfbench
echo "$(rm -rf perfbench objs )"
echo "$(rm -rf perfbench_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./perfbench amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./perfbench_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./rt
echo "$(rm -rf rt objs )"
echo "$(rm -rf rt_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./rt amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./rt_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./sponza* amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./sort
echo "$(rm -rf sort objs )"
echo "$(rm -rf sort_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./sort amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./sort_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./stencil
echo "$(rm -rf stencil objs )"
echo "$(rm -rf stencil_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./stencil amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./stencil_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../

cd ./volume_rendering
echo "$(rm -rf volume objs )"
echo "$(rm -rf volume_knl objs_knl )"
echo "$(make -f Makefile_knl )"
echo "$(make -f Makefile_knl_native )"
echo "$(scp -r ./volume amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./volume_knl amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./camera.dat amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
echo "$(scp -r ./density_highres.vol amitrokh@msticlxl98:/users1/amitrokh/perf/ )"
cd ../
