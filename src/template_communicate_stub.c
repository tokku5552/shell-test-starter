#include <stdio.h>

int main(int argc, char *argv[])
{
    int i;

    printf("実行コマンド:");
    for (i = 0; i < argc; i++)
    {
        printf(" %s", argv[i]);
    }
    char buffer[256] = "";

    printf("\n---heredoc recieved from here---\n");
    while (1)
    {
        if (scanf("%255[^\n]%*[^\n]", buffer) == EOF)
        {
            break;
        }
        scanf("%*c");
        printf("> %s\n", buffer);
    }
    printf("---heredoc end---\n");
    return 0;
}