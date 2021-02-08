#include <stdio.h>

int main(void)
{

    char buffer[256] = "";

    printf("Input: ");
    while (1)
    {

        if (scanf("%255[^\n]%*[^\n]", buffer) == EOF)
        {
            continue;
        }
        scanf("%*c");
    }
    printf("Output: %s\n", buffer);
    return 0;

    // int moji;

    // while ((moji = getchar()) != EOF)
    // {
    //     printf("取得した文字:%c\n", moji);
    // }

    // return 0;
}