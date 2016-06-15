#!/bin/bash

fatpack trace --use=JSON::PP --use=vperl::vpp bin/dist_surveyor
fatpack packlists-for `cat fatpacker.trace` > fatpacker.packlists
./process_fatpacker_packlist.pl fatpacker.packlists
fatpack tree `cat fatpacker.packlists`
fatpack file bin/dist_surveyor > dist_surveyor_packed.pl
rm -R fatpacker.trace fatpacker.packlists fatlib
