# You can use weak account keys, or full account keys (but I would not recommend it)
# If you feel particularly generous, you can donate some computing time to my account
# by leaving the variables as shown. 
# Otherwise change the below to your accounts. 
projects=(
	"http://einstein.phys.uwm.edu/ 513936_5584f26293a372be6f27fc1b4b2de7ee"
	"http://milkyway.cs.rpi.edu/milkyway/ 148440_8bc33db82f68397d715177262799d653"
	"http://asteroidsathome.net/boinc/ 113665_6d98e46e0677f4cdbea6f67709058be2"
	"http://pogs.theskynet.org/pogs/ 76885_ac75c7d6a8433a0f094799d03ffed8d8"
)

function run_boinccmd {
	boinccmd $@
}

function boinc_get_projs {
	return `run_boinccmd --get_project_status | grep "master URL" | cut -d':' -f 2,3`
}

function boinc_project_batch {
	for x in $(seq 0 $(( ${#projects[@]} -1 )) ); do 
		echo "executing \"$1\" \"$3\" on project: $(echo ${projects[$x]} | cut -d' ' -f 1)";
		if [[ $2 == "auth" ]]; then
			run_boinccmd  $1  ${projects[$x]} $3;
		else
			run_boinccmd  $1  $(echo ${projects[$x]} | cut -d' ' -f 1) $3;
		fi
		echo "Done";
	done
}

function boinc_attach_my_projects {
	boinc_project_batch "--project_attach" auth
}

function boinc_detach_my_projects {
	boinc_project_batch "--project" noauth "detach"
}

function boinc_proj_suspend {
	boinc_project_batch "--project" noauth "suspend"
}

function boinc_proj_resume {
	boinc_project_batch "--project" noauth resume
}

function boinc_proj_no_more_work {
	boinc_project_batch "--project" noauth "nomorework"
}

function boinc_proj_allow_more_work {
	boinc_project_batch "--project" noauth allowmorework
}

function boinc_taillog {
	tail -f  /var/lib/boinc-client/stderrdae.txt
}





	


