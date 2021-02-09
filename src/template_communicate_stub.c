#include <stdio.h>
#include <string.h>
#include <unistd.h>

char *getmodulefilename()
{
    static char buf[1024] = {"\0"};
    readlink("/proc/self/exe", buf, sizeof(buf) - 1);
    return buf;
}

int main(int argc, char *argv[])
{
    // argv[0](実行コマンド)の先頭が./であれば除去する
    char cmd_name[64];
    sscanf(argv[0], "%s", &cmd_name);
    char t[64];
    if (cmd_name[0] == '.' && cmd_name[1] == '/')
    {
        // 含まれる場合
        strncpy(t, cmd_name + 2, strlen(cmd_name) - 2);
        t[strlen(cmd_name) - 2] = '\0';
    }
    else
    {
        // 含まれていない場合
        strncpy(t, cmd_name, strlen(cmd_name));
        t[strlen(cmd_name)] = '\0';
    }

    // ヒアドキュメントの読み込み
    int i;
    printf("実行コマンド: %s", t);
    for (i = 1; i < argc; i++)
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

    // ファイル読み込み
    char fname[64];
    printf("%s\n", getmodulefilename());
    sscanf(getmodulefilename(), "%s", &fname);
    strcat(fname, ".dat");
    FILE *fp;
    fp = fopen(fname, "r");

    // ファイルから値を取得しそのまま返却値として返却
    int ret;
    while (fscanf(fp, "%d", &ret) != EOF)
    {
    }

    fclose(fp);
    return ret;
}