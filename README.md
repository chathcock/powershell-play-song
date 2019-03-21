# powershell-play-song
Just a silly project to play (spread)sheet music in powershell.

## Usage
`.\Play-Song.ps1 -Sheet .\<file>.csv -Verbose`

The verbose parameter is optional and will print note information. This is useful for finding errors in your sheet.

For example, this command:

`.\Play-Song.ps1 -Sheet .\odetojoy.csv`

Will play the included demo song, Ode to Joy.

## Music Format
Music is stored as comma separated values which you can edit in your favorite text editor or spreadsheet.

Line 1 should consist of `Note,Octave,Value,BPM,Title`, line 2 should include the first note along with the bpm and song title, and lines 3 and onward should consist of just a note, octave, and value, with bpm and title left blank. Here is an example using the first three notes of Ode to Joy:

```
Note,Octave,Value,BPM,Title
E,3,q,120,Ode to Joy
E,3,q,,
F,3,q,,
```

### Notes
Valid notes are C, Cs/Df, D, Ds/Ef, E, F, Fs/Gf, G, Gs/Af, A, As/Bf, and B. A note followed by an s is sharp and one followed by an f is flat. For example, C is just `C`, while B♭ is `Bf` and D♯ is `Ds`.

Rests are indicated by an `R`. Octave data is skipped for rests but the value should be filled in to indicate its length.

### Octaves
You can type any number you want here, but you'll get errors if you put anything lower than 1 on Ds or higher than 11 on C. This is because Console.Beep is limited to frequencies between 37 Hz and 32767 Hz.

### Value
```
w  = 1      # whole note
hd = 0.75   # dotted half note
h  = 0.5    # half note
qd = 0.375  # dotted quarter note
q  = 0.25   # quarter note
e  = 0.125  # eigth note
s  = 0.0625 # sixteenth note
```

### Complete Syntax
A C quarter note in octave 4 followed by a D sharp dotted half note in octave 3, followed by a full rest would look like this:
```
C,4,q,,
Ds,3,hd,,
R,,w,,
```
Note that the extra commas denote the blank BPM and Title columns. The octave is optional on a rest and will be ignored. You can leave it blank or fill in a number if it's convenient.

### Comments
Note that since BPM and Title are only read on row 2 of the csv, you can use the BPM and Title columns to store instructions or other comments. Here's an example:
```
Note,Octave,Value,BPM,Title
C,4,q,80,My Demo Song
E,3,q,,
E,3,q,,This part of the song is really repetive
E,3,q,,End of first measure
E,3,q,,
Ds,3,hd,,End of second measure
R,,w,,End of third measure
```
Do not use commas in your comments.

## License
See the license file, both the script and the arrangemenet are in the public domain. Arrangement derived from [this arrangement](https://www.mutopiaproject.org/cgibin/piece-info.cgi?id=528), which is also in the public domain.
