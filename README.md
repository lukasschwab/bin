# bin

A potpourri of scripts.

## Fresh machine setup

1. Install Xcode Command Line Tools

    ```bash
    xcode-select --install
    ```

2. Install Homebrew and gh

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

    On Apple Silicon, add Homebrew to your PATH (the installer prints these instructions):

    ```bash
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ```

    Then install gh:

    ```bash
    brew install gh
    ```

3. Authenticate and clone this repo

    ```bash
    gh auth login
    gh repo clone lukasschwab/bin ~/bin
    ```

4. Run setup script

    ```bash
    ~/bin/bin-setup.sh
    ```

    This installs CLI tools, GUI applications, Oh My Zsh, plugins, and symlinks dotfiles.

5. Configure shell: create `~/.zshrc` with a single line:

    ```bash
    source ~/bin/binrc
    ```

    Your `.zshrc` can contain additional machine-specific configuration or secrets after this line.

### Dotfiles

Dotfiles are stored in `~/bin/dotfiles/` and symlinked to their expected locations:

| Source | Symlink |
|--------|---------|
| `dotfiles/nvim/init.lua` | `~/.config/nvim/init.lua` |
| `dotfiles/zsh/lukas.zsh-theme` | `~/.oh-my-zsh/custom/themes/lukas.zsh-theme` |

Changes to dotfiles in this repo are automatically applied after `git pull` (symlinks read directly from the repo).

## Docs

<!-- GENERATEDCONTENT -->

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

### `bin-setup.sh`

```
bin-setup.sh sets up a fresh macOS machine with CLI tools, GUI apps, and dotfiles.

Requires Homebrew. See README for full setup instructions.

Usage:
  ~/bin/bin-setup.sh
```

### `blog`

```
blog is a limited bash leveled-logging utility.

Usage:
  blog [debug|info|warn|error] <message>

Examples:
  blog debug "Here is debug context."
  blog info "Here is some useful info."
  blog warn "Here is a warning. Hmm..."
  blog error "Ack, an error! Oh no!"

NOTE 2025-12-23: consider using https://github.com/charmbracelet/gum instead.
```

### `commits`

```
commits in the current repo pretty-represented in fzf, with patch previews.
Uses fzf: https://github.com/junegunn/fzf
```

### `compare`

```
compare two commits in the current GitHub repo in the browser.
Uses gh: https://cli.github.com/
```

### `contributions`

```
List GitHub contributions (commits) by a given user in a given organization.

Uses:
	+ gh: https://cli.github.com/
	+ gum: https://github.com/charmbracelet/gum
	+ jq: https://jqlang.org/
```

### `dcover`

```
dcover checks the coverage impact of merging the current Go monorepo branch
into main.

Uses colordiff: https://formulae.brew.sh/formula/colordiff

Example:
  git checkout featurebranch
  dcover
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

### `gitclean`

```
gitclean proposes branches to delete (GitHub remote). Requires gh, gum.

Usage:
  gitclean
```

### `gitdone`

```
gitdone deletes the current feature branch and returns to an updated
main branch. See: mainbranch.
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

### `mainbranch`

```
mainbranch returns "main" if the current git repository has a branch named
"main." Otherwise, if the repostiory has a branch named "master," mainbranch
returns "master."
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

### `moddoc`

```
View go docs for stdlib packages or packages in the current module.

Uses fzf: https://github.com/junegunn/fzf

Usage:
	moddoc
	moddoc ./...		Same as above.
	moddoc ./... std	Include stdlib.
```

### `mp3-dl`

```
mp3-dl downloads a YouTube video's audio as an MP3.
Uses yt-dlp: https://github.com/yt-dlp/yt-dlp
Use with id3ed to edit MP3 metadata: https://github.com/lukasschwab/id3ed

Usage:
  mp3-dl https://www.youtube.com/watch\?v\=MH_D26i2NyE
```

### `nato`

```
nato bar returns Bravo Alfa Romeo. I use this most often when talking to
customer service and need to read out a long alphanumeric string, which has
only happened a couple of times in my whole life. But it’s sometimes useful!

Blog post source: https://evanhahn.com/scripts-i-wrote-that-i-use-all-the-time/
Source: https://codeberg.org/EvanHahn/dotfiles/src/commit/843b9ee13d949d346a4a73ccee2a99351aed285b/home/bin/bin/nato
```

### `nw`

```
nw opens a new Ghostty terminal window with a selected theme.

Uses fzf to select a theme with a color palette preview.
The new window launches detached from the current terminal.

Usage:
  nw                    # Interactive theme picker
  nw --light            # Pick from light themes only
  nw --dark             # Pick from dark themes only
  nw <theme>            # Launch directly with specified theme
  nw --preview <theme>  # Show theme preview (used internally by fzf)

Requires: ghostty, fzf
```

### `path`

```
path sorts and prints all components of the current path. Could just as well
be an alias instead.
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

### `pick`

```
pick a random file in in the current working directory (recursive).
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

### `tikz2svg`

```
tikz2svg converts a tikz document to SVG, via PDF.

Uses:
  + xelatex (though it should be easy to sub in pdflatex) and
  + pdf2svg: https://formulae.brew.sh/formula/pdf2svg

Usage: tikz2svg [someTikzFile.tex]
Example input: https://gist.github.com/lukasschwab/6a3e2cdd78075e8923a9057f7609a898

See also: https://pandoc.org/lua-filters.html#building-images-with-tikz
```

### `today`

```
t -e
t -u
t -o pipefail
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

### `unstash`

```
unstash from `git stash list`: fzf with preview.
Uses fzf: https://github.com/junegunn/fzf

Usage:
unstash
```
