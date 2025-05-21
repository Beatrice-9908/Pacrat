# Pacrat/Miscrat  


![image](https://github.com/user-attachments/assets/7a3ad23b-49ca-4ad2-922e-94c7c7bb39e8)



## Overview:
This project was designed to automate the creation of package tracking files for pacman and the AUR. These files can then be used to restore the system with the accompying scripts.  
&nbsp;  
The goal is to create an easy way to implement some best practices of package backup as detailed in the Arch linux wiki. 
I have linked the page with its relevant section from the wiki below. 

[Arch linux wiki: Pacman Tips and Tricks](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#:~:text=Install%20packages%20from%20a%20list)

## What is it: 

### Pacrat: 
Bash script that assists in running pacman commands to install or remove packages based on a pkglist file. The pkglist file is created and maintained by a pacman alpm hook.

### Miscrat: 
Bash script that assists in the creation and maintanence of package list files for AUR packages.

## Usage:
```pacrat [OPTION] [IMAGEFILE]```
<pre>
-h              	Display options
-i              	Make a copy of the pkglist file and append current date to name
-l              	Show all pacrat images

-s	[IMAGEFILE]	Show packages in given image
-c	[IMGAEFILE]	Shows packages that will be removed for a given image

-w	[IMAGEFILE]	Install all needed packages from pkglist
-r	[IMAGEFILE]	Remove all conflicting packages between system and pkglist
</pre>
```miscrat [OPTION] [IMAGEFILE]```
<pre>
-h              	Display Options
-i              	Make a copy of the foreignpkglist and append date to name
-l              	Show all miscrat images

-s	[IMAGEFILE]	Show packages in given image
</pre>

## Example usage with output:
<details>
<summary>listing image files</summary>
<pre>
$ pacrat -l
pkglist m_d_H_M
pkglist_current</pre>
</details>
<details>
<summary>checking an image file before removal</summary>
<pre>
$ pacrat -c m_d_H_M
# Pacrat Package Check #<br>


pkgname

These packages will be removed</pre>
</details>
<details>
<summary>removing packages with an image file</summary>
<pre>
$ pacrat -r m_d_H_M
</pre>
This command will run the pacman command pacman -Rsu $(comm -23 <(pacman -Qq | sort) <(sort pkglist_m_d_H_M))
If you use it you will most likely need sudo for this command.
</details>
  
## Pacratconf
Pacrat's image storage path configuration is stored in the directory /etc/pacrat
&nbsp;  

When editing the configuration file for pacrat's image storage path only use one space before the start of your path. Omitting the last '/' after your desired path is also required.
&nbsp;  

<details>
<summary>Example config</summary>
<pre>
[Path] = /home/user
</pre>
</details>
