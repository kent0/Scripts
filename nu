if [ -f logfile ]; then
    grep fluxes1 logfile | awk '{print $2","$9}' > nu.csv
fi
