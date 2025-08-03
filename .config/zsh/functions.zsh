todos() {
    local year=${1:-$(date +%Y)}
    local month=${2:-$(date +%m)}
    
    echo "Summarizing todos for $year-$month from $HOME/notes/daily/$year..."
    
    if "$HOME/.scripts/summarize_completed_todos.sh" "$year-$month" "$HOME/notes/daily/$year"; then
        local summary_file="$HOME/notes/daily/summaries/summary_$year-$month.txt"
        echo "Opening $summary_file..."
        /bin/cat "$summary_file"  # Använd full sökväg
        # eller
        # ${EDITOR:-/usr/bin/vim} "$summary_file"
    fi
}
