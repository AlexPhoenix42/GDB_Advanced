function vgdbme_launch
    if test (count $argv) -eq 0
        echo "Usage: run_valgrind <program_to_run>"
        return 1
    end

    echo %self > valgrind.pid
    exec valgrind --vgdb=yes --vgdb-error=0 $argv
end
