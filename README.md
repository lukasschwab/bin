# bin

A potpourri of scripts.

## Common tools

These are either dependencies of scripts in this directory, or else just software I use regularly.

### CLI utilities

+ 🍺 `ag`
+ 🍺 `fzf`
+ 🍺 `watchman`
+ 🍺 `twilio`
+ 🍺 `jq`
+ ⬇️[`gcloud`](https://cloud.google.com/sdk/docs#install_the_latest_cloud_tools_version_cloudsdk_current_version)

### Languages

+ 🍺 `go`
+ 🍺 `python`
+ 🍺 `node`

### Images & video tools

+ 🍺 `imagemagick`
+ 🍺 `youtube-dl`
+ 🍺 `webp`: includes utils like `dwebp`.

### PDF tools

+ 🍺 `pandoc`
+ 🍺 `ghostscript`
+ 🐍 `noteshrink`
+ 🐙 [`pdfscale`](https://github.com/tavinus/pdfScale)

## Docs

<!-- GENERATEDCONTENT -->

### `al`

```
al opens the lexicographically last file in a directory with atom.
The custom exemptions might become unwieldy; this may not be extensible.
```

### `bashdoc`

```
bashdoc prints the contents of a file until the first blank line.
This is useful for bash scripts that begin with documentation before the code,
which I aim to standardize in bin. This way, I can use bashdoc to echo help
strings without replicating them.

Usage:
  bashdoc <filename>

Examples:
  # Print the bashdoc for some bash utility.
  bashdoc phone
  # Print the bashdoc for the current script.
  bashdoc "$BASH_SOURCE"
```

### `blog`

```
blog is a limited bash leveled-logging utility.

Usage:
  blog [info|warn|error] <message>

Examples:
  blog info "Here is some useful info."
  blog warn "Here is a warning. Hmm..."
  blog error "Ack, an error! Oh no!"
```

### `croppedhistory`

```
croppedhistory removes the line numbers from history output for deduping.
It also does some stuff I don't fully understand, because I wrote it when
I first wrote hg.
```

### `feedscan`

```
Feedscan checks common feed suffixes for a webpage.

Usage:
  feedscan [url]

Examples:
  feedscan lukasschwab.me/blog
  feedscan lukasschwab.me/blog/
  feedscan http://lukasschwab.me/blog/
  feedscan https://lukasschwab.me/blog/
```

### `gir`

```
gir greps recursively in the pwd, ignoring binary files.
Note: just use `ag` for speed. `brew install the_silver_searcher`
```

### `gofind`

```
Find the path to a package buried in your GOPATH.
Uses fzf: https://github.com/junegunn/fzf

To conveniently cd to the found directory, set a function in your .zshrc:
  goto() { cd $(gofind) }
 $GOPATH/src;
echo $GOPATH/src; find * -type d -not -path '*/\.*' | fzf; } | tr "
" "/";
ho "";
```

### `gore`

```
GO RElease: routine checks for go packages.
```

### `gsl`

```
fzf search on the files in `git status` output.
Uses fzf: https://github.com/junegunn/fzf

Usage, e.g.:
  gsl diff
  gsl add
  gsl checkout - check out files
  gsl -b checkout - check out branches

Use TAB to multiselect in `fzf`.
```

### `hf`

```
hf pipes history into fzf for finding commands you can't remember.
```

### `hg`

```
hg pipes history into grep for finding commands you can't remember.
oppedhistory | grep -h $1
```

### `lsf`

```
lsf pipes ls results into fzf.

Standard useage:
	lsf
List all files:
	lsf -a
```

### `margins`

```
margins shrinks PDF contents by 20% and splats them into a letter-size page
to add margins to them.

NOTE: this operation is not in-place; a copy of the PDF is created.

Uses pdfscale: https://github.com/tavinus/pdfScale

Usage: `margins some.pdf`
  Yields some.LETTER.SCALED.pdf.
```

### `pdfcat`

```
pdfcat uses PhantomJS to retrieve websites as PDFs, then catenates the PDFs
into a single PDF with Ghostscript. Spooky!

Usage: pdfcat https://scrty.io/start-here \
  https://medium.com/starting-up-security/starting-up-security-87839ab21bae \
  ... any number of URLs.
```

### `phone`

```
Uses Twilio to notify me of a long task completing.
e.g.:
   $ gcloud app deploy; phone
Setup:
   Set up Twilio API/CLI: https://www.twilio.com/docs/twilio-cli/quickstart
   Add two variables to .zshrc:
      TWILIO_NUMBER="+1234567890"   # A number from which Twilio can send.
      PERSONAL_NUMBER="+0987654321" # The number that will be notified.
```

### `semvercompare`

```
semvercompare compares two semantic versions with the same number of
components.

Usage: semvercompare <v0> <v1>
  semvercompare 1.2.10 1.3.10

Output:
  1 - when v0 is later than v1
  0 - when v0 and v1 are the same
 -1 - when v0 is earlier than v1
```

### `todo`

```
todo lists incomplete tasks in/below your pwd.
```

### `topdf`

```
topdf is a wrapper for a standard Pandoc configuration for rendering a
simple Markdown file as a PDF. Requires pandoc, xelatex.

Usage:
  pandoc <filename.md>
  # You can pass additional pandoc arguments.
  pandoc <filename.md> --toc
```
