#!/bin/bash

PERL5LIB="./lib:$PERL5LIB" fatpack trace --use=JSON::PP --use=File::Which --use=IPC::System::Simple bin/dist_surveyor
fatpack packlists-for `cat fatpacker.trace` > fatpacker.packlists
./process_fatpacker_packlist.pl fatpacker.packlists
fatpack tree `cat fatpacker.packlists`
fatpack file bin/dist_surveyor > dist_surveyor_packed.pl
rm -R fatpacker.trace fatpacker.packlists fatlib
