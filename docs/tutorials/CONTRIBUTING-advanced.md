# Contributing Advanced

To contribute to https://learn.secretnodes.org please follow these guidelines.

## Setting up your environment

install docsify-cli globally, which helps initializing and previewing the website locally.

```bash
npm i docsify-cli -g
```

## Clone the repo

Check out the code and go into the docs directory:

```bash
git clone https://github.com/secretnodes/learn.git
cd docs
```

## Initialize

Start docsify from the `./docs` subdirectory, use the `init` command.

```bash
docsify init ./docs
```

## Writing Tutorials

To edit or add tutorials, cd into the tutorials folder and either edit or create new tutorials in markdown.

```bash
cd ./docs/tutorials
```

Now simply edit the markdown files with your favorite editor. To test this out, go ahead and edit the contributing-advanced.md tutorial.

```bash
nano contributing-advanced.md
```
 
Then preview the changes on your local machine by doing the following.

```bash
cd ./learn
```
Then serve the site on your local machine.

```bash
docsify serve docs
````

Congratulations! 🎉 You are now a Developer😏