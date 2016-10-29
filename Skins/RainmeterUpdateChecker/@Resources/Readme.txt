RAINMETER UPDATE CHECKER
Version 2.0.0
By iamanai

========================================
ABOUT

This package includes a tutorial for creating an update checker for your Rainmeter
skin suite, using droppages.com to host a very simple website free of charge.
Included also is the base LUA script for accomplishing this, as well as a tutorial
for implementing it into your own skin suites.

Created and published by iamanai

This software is released to you under a Creative Commons BY-NC-SA 3.0 license.
Source code is available on GitHub under the MIT License.

========================================
IMPLEMENTATION TUTORIAL

There are three main things you must consider when implementing this functionality
into your own skin suite: The script itself, the webparser measure, and the output
meter. The majority of the work is done in the script itself, so you don't have to
worry about that. If you would like to know how the update checker itself works,
there is documentation in the script that will provide that information.

So, on to implementing this yourself. You will notice two scripts in the scripts
folder: UpdateChecker.lua, and UpdateCheckerRe.lua. You will be using
UpdateCheckerRe.lua to implement into your own skins (UpdateChecker.lua has the
extra documentation, as well as hard-coded actions for this sample skin only).
