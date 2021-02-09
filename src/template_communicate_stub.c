#include <stdio.h>

int main(int argc, char *argv[])
{
    int i;

    for (i = 1; i < argc; i++)
    {
        printf("第%d引数：%s\n", i, argv[i]);
    }
    char buffer[256] = "";

    printf("Communicate command start\n");
    while (1)
    {

        if (scanf("%255[^\n]%*[^\n]", buffer) == EOF)
        {
            break;
        }
        scanf("%*c");
        printf("Output: %s\n", buffer);
    }
    printf("Communicate command end\n");
    return 0;
}