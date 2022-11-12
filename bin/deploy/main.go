// Deploy script for github pages
// Loosely based on Docusaurus Github Pages deploy script
// https://github.com/facebook/docusaurus/blob/542228ee1beb5cfddd7ba8ae088f109f164e80c5/packages/docusaurus/src/commands/deploy.ts#L43
// Run `make serve` and open http://localhost:3000 in your browser

package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"strings"
)

const (
	projectName      = "charlesancheta.com"
	deploymentBranch = "gh-pages-test"
	// TODO: Change to real branch once done
	// deploymentBranch = "gh-pages"
)

func getCmdOutput(name string, arg ...string) (string, error) {
	out, err := exec.Command(name, arg...).Output()
	if err != nil {
		return "", err
	}
	return strings.TrimSpace(string(out)), nil
}

func execCmd(name string, arg ...string) error {
	cmd := exec.Command(name, arg...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	return cmd.Run()
}

type gitOptions struct {
	url    string
	branch string
	hash   string
}

func getGitOptions() gitOptions {
	url, err := getCmdOutput("git", "config", "--get", "remote.origin.url")
	if err != nil {
		log.Fatalf("failed to get origin url: %v", err)
	}
	branch, err := getCmdOutput("git", "rev-parse", "--abbrev-ref", "HEAD")
	if err != nil {
		log.Fatalf("failed to get branch: %v", err)
	}
	hash, err := getCmdOutput("git", "rev-parse", "HEAD")
	if err != nil {
		log.Fatalf("failed to get commit hash: %v", err)
	}

	return gitOptions{url, branch, hash}
}

func mkTmpDir() (string, func()) {
	dir, err := ioutil.TempDir(os.TempDir(), projectName+"-"+deploymentBranch)
	if err != nil {
		log.Fatalf("failed to make temp dir: %v", err)
	}
	return dir, func() { os.RemoveAll(dir) }
}

func main() {
	output, cleanOutput := mkTmpDir()
	defer cleanOutput()
	gitPublish, cleanGitPublish := mkTmpDir()
	defer cleanGitPublish()

	// Make sure to create a new build output every time since it's blazingly fast anyway
	err := execCmd("hugo", "-d", output)
	if err != nil {
		log.Fatalf("failed to build: %v", err)
	}

	options := getGitOptions()

	os.Chdir(gitPublish)
	err = execCmd("git", "clone", "--depth", "1", "--branch", deploymentBranch, options.url, gitPublish)
	if err != nil {
		// Branch doesn't exist, create new branch
		execCmd("git", "init")
		execCmd("git", "checkout", "-b", deploymentBranch)
		execCmd("git", "remote", "add", "origin", options.url)
	} else {
		// Simply remove all files
		execCmd("git", "rm", "-rf", ".")
	}
	// Sorry, UNIX only
	os.Chdir(output)
	err = execCmd("cp", "-r", ".", gitPublish)
	if err != nil {
		log.Fatalf("failed to copy output to publish dir: %v", err)
	}
	os.Chdir(gitPublish)
	execCmd("git", "add", "--all")
	msg := fmt.Sprintf("Deploy website - based on %s", options.hash)
	commitErr := execCmd("git", "commit", "-m", msg)
	err = execCmd("git", "push", "--force", "origin", deploymentBranch)
	if err != nil {
		log.Fatalf("failed to push to origin: %v", err)
	} else if commitErr == nil {
		fmt.Printf("Website is live at: https://%s\n", projectName)
	}
}
