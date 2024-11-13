function envsource
    for line in (cat $argv | grep -v '^#')
        set item (string split -m 1 '=' $line)
        if test $status -ne 0
            continue
        end

        set -gx $item[1] $item[2]
        echo "Exported key $item[1]=$item[2]"
    end
end
