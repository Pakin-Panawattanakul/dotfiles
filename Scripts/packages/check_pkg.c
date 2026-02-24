#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define PKG_LENGHT 100

// cut out the line that are not package name
// return value
// true : is a package name
// false : is not a package name
bool check_pkg_format(char *str) {
  bool valid = false;
  while (*str) {
    if (*str == '#' || *str == '(' || *str == ')')
      return false;
    if (*str != ' ' && *str != '\n')
      valid = true;
    str++;
  }
  return valid;
}

// similar to string.strip() in python
// remove the end line and space from the package name
void extract_name(char *str) {
  char pkg_name[PKG_LENGHT] = "";
  char *ptr = str;
  int i = 0;
  while (*ptr != '\n') {
    if (*ptr == ' ') {
      ptr++;
      continue;
    }
    pkg_name[i] = *ptr;
    i++;
    ptr++;
  }
  strcpy(str, pkg_name);
}
// use to compare package name to the list of package to the given array
// current are use two time both ways
// return : it package is inside the array or not
bool pkg_in(char *pkg, char (*cpkg_list)[PKG_LENGHT], int count) {
  pkg[strcspn(pkg, "\n")] = '\0';
  for (int i = 0; i < count; i++) {
    if (strcmp(pkg, *cpkg_list) == 0) {
      return true;
    }
    cpkg_list++;
  }
  return false;
}


int main(int argc, char **argv) {
  const int NUMS_PACKAGE = 300;
  int count_cpkg = 0;
  if (argc != 2) {
    printf("Incorrect usage: ./check_pkg <categorized package list>\n");
    return -1;
  }
  char buffer[PKG_LENGHT];

  // this is file that we are editing and try to categorize pkgs
  // printf("----------Categorized packges ----------\n");
  FILE *fptr0;
  fptr0 = fopen(argv[1], "r");
  if (!fptr0) {
    printf("Invalid categorized package list\n");
    return -1;
  }
  
  // save package list of the categorized packages files
  // the one that we are manually editing
  // pkg_ptr pointer is char pointer of size [PKG_LENGHT]
  // each pkg_ptr++ move PKG_LENGHT address => new pkg
  // the pointer will be used in generated pkgs as well
  char categorized_pkg_list[NUMS_PACKAGE][PKG_LENGHT];
  char (*pkg_ptr)[PKG_LENGHT] = categorized_pkg_list;

  while (fgets(buffer, PKG_LENGHT, fptr0)) {
    if (check_pkg_format(buffer)) {
      extract_name(buffer);
      strcpy(*pkg_ptr, buffer);
      pkg_ptr++;
      count_cpkg++;
    }
  }
  fclose(fptr0);

  // do the same thing with the generated package list
  // generated package list from
  // arch : pacman -Qqe > filename 
  // deb  : apt list --installed > filename
  FILE *fptr1;
  char generated_pkg_list[NUMS_PACKAGE][PKG_LENGHT];
  pkg_ptr = generated_pkg_list;
  int count_pkg = 0;

  system("pacman -Qqe > .generated_pkg");
  fptr1 = fopen(".generated_pkg", "r");
  if (!fptr1) {
    printf("Invalid generated package list\n");
    return -1;
  }
  while (fgets(buffer, PKG_LENGHT, fptr1)) {
    if (check_pkg_format(buffer)) {
      extract_name(buffer);
      strcpy(*pkg_ptr, buffer);
      pkg_ptr++;
      count_pkg++;
    }
  }
  fclose(fptr1);

  // comparing each generated package name to categorize package list
  // if not inside => need to be categorize
  int count_uncategorized = 0, count_deleted = 0;
  printf("----- Package in the system, not in the list -----\n");
  for (int i = 0; i < count_pkg; i++){
    if(!pkg_in(generated_pkg_list[i], categorized_pkg_list, count_cpkg)){
      printf(" %s\n",generated_pkg_list[i]);
    }
  }
  //printf("\ntotal %d packages are uncategorized\n\n", count_uncategorized);

  printf("----- Packages in the list, not in the system -----\n");
  for (int i = 0; i < count_cpkg; i++){
    if(!pkg_in(categorized_pkg_list[i], generated_pkg_list, count_pkg)){
      printf(" %s\n",categorized_pkg_list[i]);
    }
  }
  //printf("\ntotal %d packages\n", count_deleted);
  printf("---------------------------------------------------\n");

  return 0;
}
