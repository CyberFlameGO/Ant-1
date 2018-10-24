cmake_minimum_required(VERSION 3.12)
project(Ant)

set(CMAKE_CXX_STANDARD 11)

add_executable(Ant main.c)
add_executable(Ant cpa_handler.m)