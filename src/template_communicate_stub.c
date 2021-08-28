#include <stdio.h>
#include <string.h>
#include <unistd.h>

// Function to get the path of the execution command
// Only available on Linux
char *getfilepath()
{
    static char buf[1024] = {"\0"};
    readlink("/proc/self/exe", buf, sizeof(buf) - 1);
    return buf;
}

int main(int argc, char *argv[])
{
    // If the beginning of argv[0] (execution command) is ./, remove it.
    char cmd_name[64];
    sscanf(argv[0], "%s", &cmd_name);
    char t[64];
    if (cmd_name[0] == '.' && cmd_name[1] == '/')
    {
        // included
        strncpy(t, cmd_name + 2, strlen(cmd_name) - 2);
        t[strlen(cmd_name) - 2] = '\0';
    }
    else
    {
        // not included
        strncpy(t, cmd_name, strlen(cmd_name));
        t[strlen(cmd_name)] = '\0';
    }

    // Reading here documents
    int i;
    printf("run command: %s", t);
    for (i = 1; i < argc; i++)
    {
        printf(" %s", argv[i]);
    }
    char buffer[256] = "";

    printf("\n---heredoc recieved from here---\n");
    // Loop part that accepts input from here documents and terminals
    while (1)
    {
        if (scanf("%255[^\n]%*[^\n]", buffer) == EOF)
        {
            break;
        }
        // Exit the loop when exit is entered
        if (strstr(buffer, "exit") != NULL)
        {
            break;
        }
        // Abnormal termination when a specific character is entered
        if (strstr(buffer, "special keyword") != NULL)
        {
            return 1;
        }
        scanf("%*c");
        printf("> %s\n", buffer);
    }
    printf("---heredoc end---\n");

    // File reading
    char fname[64];
    sscanf(getfilepath(), "%s", &fname);
    strcat(fname, ".dat");
    FILE *fp;
    fp = fopen(fname, "r");

    // Get the value from the file and return it as it is
    int ret;
    while (fscanf(fp, "%d", &ret) != EOF)
    {
    }

    fclose(fp);
    return ret;
}