#!/usr/bin/python
# vim: ts=4 ai expandtab

import os

projects = {
    "http://einstein.phys.uwm.edu/":
        "513936_6c390bcac62b13c41ea3256e49fb8964",
    "http://milkyway.cs.rpi.edu/milkyway/":
        "148440_8bc33db82f68397d715177262799d653",
    "http://asteroidsathome.net/boinc/":
        "113665_6d98e46e0677f4cdbea6f67709058be2",
    "http://pogs.theskynet.org/pogs/":
        "76885_ac75c7d6a8433a0f094799d03ffed8d8"
}


def run_boinccmd(cmdlist, pname=None):
    if pname is not None:
        cmdlist = map(lambda x: x % pname, cmdlist)
    print "executing ", "boinccmd %s" % (' '.join(cmdlist))
    return os.system("cd ~ && boinccmd %s" % (' '.join(cmdlist)))


def boinc_get_projs():
    return run_boinccmd([" --get_project_status"])


def boinc_project_batch(cmd=""):
    for proj in projects:
        run_boinccmd([cmd], proj)  # projects[proj]])


def boinc_attach_my_projects():
    boinc_project_batch("--project_attach %s auth")


def boinc_detach_my_projects():
    boinc_project_batch("--project %s  detach")


def boinc_proj_suspend():
    boinc_project_batch("--project %s  suspend")


def boinc_proj_resume():
    boinc_project_batch("--project %s  resume")


def boinc_proj_update():
    boinc_project_batch("--project %s  update")


def boinc_proj_no_more_work():
    boinc_project_batch("--project %s  nomorework")


def boinc_proj_allow_more_work():
    boinc_project_batch("--project %s  allowmorework")

