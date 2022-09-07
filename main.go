package main

import (
	"flag"
	"io"
	"log"
	"os"
	"path/filepath"
	"regexp"
)

func filesFrom(pattern string, expr string) []string {
	var files []string

	matches, err := filepath.Glob(pattern)
	if err != nil {
		log.Fatalln("Can't glob files")
	}

	excludes, err := regexp.Compile(expr)
	if err != nil {
		log.Fatalln("Can't compile regexp obj")
	}

	for _, match := range matches {
		if !excludes.MatchString(match) {
			files = append(files, match)
		}
	}

	return files
}

func files() []string {
	var files []string

	files = append(
		files,
		filesFrom("./.*", "^\\.git($|ignore|modules)|\\.config")...)
	files = append(
		files,
		filesFrom("./.config/*", "karabiner$")...)

	return files
}

func appendPath(path string, pathes []string) []string {
	var files []string

	for _, p := range pathes {
		files = append(files, filepath.Join(path, p))
	}

	return files

}

func userHomeDir() string {
	home, err := os.UserHomeDir()
	if err != nil {
		log.Fatalln("Can't get home directory")
	}

	return home
}

func getWd() string {
	wd, err := os.Getwd()
	if err != nil {
		log.Fatalln("Can't get the working directory")
	}

	return wd
}

func clean() {
	home := userHomeDir()

	for _, file := range appendPath(home, files()) {
		if err := os.Remove(file); err != nil {
			log.Printf("Failed to remove %s\n", file)
		} else {
			log.Printf("%s removed\n", file)
		}
	}
}

func copy(file string) {
	dstPath := filepath.Join(userHomeDir(), file)
	if _, err := os.Stat(dstPath); err == nil {
		log.Println("The file already exists. We expect the file doesn't exist.")
		return
	} else if os.IsNotExist(err) {
		log.Fatalln(err)
	}

	src, err := os.Open(filepath.Join(getWd(), file))
	if err != nil {
		log.Fatalln(err)
	}
	defer src.Close()

	dst, err := os.Create(dstPath)
	if err != nil {
		log.Fatalln(err)
	}
	defer dst.Close()

	if _, err := io.Copy(dst, src); err != nil {
		if os.IsExist(err) {
			log.Printf("%s already exists", file)
		} else {
			log.Fatalln(err)
		}
	}
}

func link() {
	home := userHomeDir()
	wd := getWd()

	for _, file := range files() {
		err := os.Symlink(
			filepath.Join(wd, file),
			filepath.Join(home, file),
		)
		if err != nil {
			log.Printf("Failed to make a symbolic link: %s\n", file)
		} else {
			log.Printf("Made a symbolic link: %s\n", file)
		}
	}

	// FIX: karabiner does't support symlink?
	copy(".config/karabiner/karabiner.json")
}

func main() {
	cleanFlag := flag.Bool("clean", false, "Clean all symbolic links that the command has created")
	linkFlag := flag.Bool("link", false, "Create symbolic links")
	flag.Parse()

	if flag.NFlag() > 1 {
		flag.PrintDefaults()
		os.Exit(1)
	}

	if *cleanFlag {
		clean()
		os.Exit(0)
	}

	if *linkFlag {
		link()
		os.Exit(0)
	}

	flag.PrintDefaults()
	os.Exit(1)
}
