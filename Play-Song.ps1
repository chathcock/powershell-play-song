param($Sheet, [switch]$Verbose)
$song = Import-Csv $sheet

# Define Constants
# ====================================================
# 
# Notes
# https://en.wikipedia.org/wiki/Piano_key_frequencies
#
# ====================================================

$note_values = @{
    C    = 16.35160
    Cs   = 17.32391
    Df   = 17.32391
    D    = 18.35405
    Ds   = 19.44544
    Ef   = 19.44544
    E    = 20.60172
    F    = 21.82676
    Fs   = 23.12465
    Gf   = 23.12465
    G    = 24.49971
    Gs   = 25.95654
    Af   = 25.95654
    A    = 27.50000
    As   = 29.13524
    Bf   = 29.13524
    B    = 30.86771
}
# ====================================================
#
# Note durations
# https://en.wikipedia.org/wiki/Note_value
#
# ====================================================

$value = @{
    w  = 1      # whole note
    hd = 0.75   # dotted half note
    h  = 0.5    # half note
    qd = 0.375  # dotted quarter note
    q  = 0.25   # quarter note
    e  = 0.125  # eigth note
    s  = 0.0625 # sixteenth note
}
# ====================================================


$index = 1          # Initialize line counter
$bpm = $song[0].BPM # BPM is imported from BPM column in song sheet.
$duration = (60/$bpm)*4000 # A whole note is 4000ms at 60bpm and it scales linearly.
"Now playing " + $song[0].Title # Announce the song

# Song player
forEach ($note in $song) {
    $length = $value[$note.Value]*$duration                        # Scale note length by bpm
    $pitch  = $note_values[$note.Note]*[math]::Pow(2,$note.Octave) # Lookup pitch on the table and scale it by the octave
    $noteName = $note.Note + $note.Octave + $note.Value
    if ($note.Note -eq "R") {
        if ($Verbose) {"Playing note #$index $noteName, resting for $length ms"}
        sleep -Milliseconds $length
    } elseif ($note_values[$note.Note] -eq $null) {
        "Oops, I didn't recognize the note $noteName on line $index of the sheet file!" # Error reporting
    } else {
        if ($Verbose) {"Playing note #$index $noteName, $pitch Hz for $length ms"}
        [console]::Beep($pitch,$length)
    }
    $index++
}
