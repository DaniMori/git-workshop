---
title: "Known issues"
output: github_document
editor:
  markdown:
    wrap:      80
    canonical: true
---

# Introduction

This is a collection of issues that can be experimented by the participants in
the workshop.

# Known issues

## Logging in to GitHub

### Problem

The participant is not logged in to GitHub

### Cause

They have probably logged in to GitHub in one browser; when they click on a link
to GitHub in the slideshow, it opens in their default browser instead of the
other one.

### Solution

Log in again to GitHub in their default browser.

## Using the GitHub repository template

### Problem

The "use this template" button does not appear in the repository template.

### Cause

The user is not logged in to GitHub (in that browser; see above).

### Solution

Log in again to GitHub in the browser they are using.

## Knitting "README.Rmd" fails

### Problem

"README.Rmd" does not knit; it throws the following error instead:

```         
|........................................          |  80% [software-versions]
 
processing file: README.Rmd
Error in `!continue`:
! invalid argument type
Backtrace:
  1. rmarkdown::render(...)
  2. knitr::knit(knit_input, knit_output, envir = envir, quiet = quiet)
  3. knitr:::process_file(text, output)
  6. knitr:::process_group(group)
  7. knitr:::call_block(x)
  8. knitr:::block_exec(params)
  9. knitr:::eng_r(options)
12. knitr (local) evaluate(...)
13. evaluate::evaluate(...)
 
Quitting from lines 56-62 [software-versions] (README.Rmd)
Execution halted
```

### Cause

Unknown. Possibly that some of the packages are missing, because the {renv}
environment was not completely restored

### Solution

Unknown. Make sure that the {renv} environment is completely updated by running
`renv::status()`. Try to restore the environment running
`renv::restore(confirm = FALSE)` if the environment is not completely restored.

### Problem

When the learner has had a GitHub account for long, and not used much, GitHub
may ask to use an "access token" to confirm their identity.

When trying to clone their own private repo then, instead of being prompted by
Rstudio to authenticate with the browser, an authentication issues rises.

### Cause

GitHub in July 2020, announced their intent to require the use of token-based
authentication for all authenticated Git operations. Beginning August 13, 2021,
they no longer accept account passwords when authenticating Git operations on
GitHub.com.

It affects the following workflows: - Command line Git access - Desktop
applications using Git (GitHub Desktop is unaffected) - Any apps/services that
access Git repositories on GitHub.com directly using their password

### Solution

Learners should use a personal access token
(<https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens>)

The easiest solution is to create a perosnal access token (classic):

- Verify your email address, if it hasn't been verified yet.
- In the upper-right corner of any page on GitHub, click your profile photo,
  then click `Settings`.
- In the left sidebar, click Developer settings.
- In the left sidebar, under Personal access tokens, click Tokens (classic).
- Select Generate new token, then click Generate new token (classic).
- In the "Note" field, give your token a descriptive name.
- To give your token an expiration, select Expiration, then choose a default
  option or click Custom to enter a date.
- Select all the scopes.
- Click Generate token.
- Optionally, to copy the new token to your clipboard, click .
