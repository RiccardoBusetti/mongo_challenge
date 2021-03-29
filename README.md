# Mongo Challenge by Riccardo Busetti
This repository contains the code necessary to run the json flattener algorithm.

## Table of contents
* [Prerequisites](#prerequisites)
* [How to run](#how-to-run)
* [How to test](#how-to-test)
* [Idea](#idea)

### Prerequisites
The code has been written in Ruby, for this reason in order to run and test the algorithm
you will need to [install Ruby on your machine](https://www.ruby-lang.org/en/downloads/).

The following commands are going to be run in the root directory of the repository, thus you will first
need to clone the repository on your machine via the following commands:
```shell
git clone https://github.com/RiccardoBusetti/mongo_challenge.git
cd mongo_challenge
```
**Important**: you may need to add execution permissions on your filesystem in order to run both `.sh` scripts.
### How to run
In order to run the program you will need to put in the root directory a file name `input.json` and follow the following steps:
```shell
./run.sh
```
### How to test
I have written a small unit testing library to embed into this challenge, in order to avoid external libraries.
In order to test my code you will need to follow the following steps:
```shell
./test.sh
```
### Idea
I have decided to implement the algorithm in Ruby as it was the fastest languages to implement it in, and it allowed
me to quickly focus on the algorithm itself, more than the implementation.

The idea of the algorithm is to loop for each entry in the json and to check its type:
* If it is not an object I simply add it to a new flattened json.
* If it is an object I recursively flatten this object and merge it to new flattened json.

In order to maintain the key naming convention with `.`, I keep track of the key naming depth via a string parameter.