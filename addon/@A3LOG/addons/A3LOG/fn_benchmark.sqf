/**********************************************************************************************************************\

    DESCRIPTION: A3LOG - A lightweight logging extension

------------------------------------------------------------------------------------------------------------------------

    CREATION DATE:  02.02.2018

------------------------------------------------------------------------------------------------------------------------

    Copyright © 2018
    Paul L. (https://github.com/Arkensor)
    All rights reserved!
    
    Based on A3EXT (https://github.com/Arkensor/A3EXT) by
    Paul L. (https://github.com/Arkensor)
    Ollie W. (https://github.com/BoGuu)

\**********************************************************************************************************************/

diag_log "A3LOG - Benchmark started ...";
[ "A3LOG - Benchmark started ..." ] call A3LOG_fnc_log;

g_nCallingThreads = 1000; //Simulating n requests from different sources like remoteexec on your server which all run in parallel
g_nCallsEach = 10; //How many calls does each of the threads do for the simulation

g_oResults = [];

[] spawn
{
    _time = diag_tickTime;

    waitUntil { ( count g_oResults ) >= ( g_nCallingThreads * g_nCallsEach ) };

    diag_log format[ "%1 request(s) (%2 threads with %3 requests each) in %4 seconds(s) - %5 seconds per request.",
                     ( count g_oResults ),
                     g_nCallingThreads,
                     g_nCallsEach,
                     ( diag_tickTime - _time ),
                     ( diag_tickTime - _time ) / ( g_nCallingThreads * g_nCallsEach ) ];
};

for "_i" from 1 to g_nCallingThreads do
{
    [] spawn
    {
        for "_i" from 1 to g_nCallsEach do
        {
            private _result = [ "this is some sample data ..." ] call A3LOG_fnc_log;
            [ "this is some sample data for the minimal config log ...", "MinimalConfigExample" ] call A3LOG_fnc_log;
            [ "this is some sample data for the rotated log file...", "RotatedExampleLog" ] call A3LOG_fnc_log;
            [ "this is some sample data for the creation timestamp log...", "CreationTimestampLog" ] call A3LOG_fnc_log;
            [ "this is some sample data for the custom formatted log with a loglevel...", "CustomFormattingAndCustomPattern", "error" ] call A3LOG_fnc_log;
            g_oResults pushBack _result;
        };
    };
};