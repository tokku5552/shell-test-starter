#include <stdio.h>
#include <string.h>
#include <unistd.h>

// 実行コマンドのパスを取得するための関数
// Linuxでのみ使用可能
char *getfilepath()
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
    printf("run command: %s", t);
    for (i = 1; i < argc; i++)
    {
        printf(" %s", argv[i]);
    }
    char buffer[256] = "";

    printf("\n---heredoc recieved from here---\n");
    // ヒアドキュメントやターミナルからの入力を受け付けるループ部分
    while (1)
    {
        if (scanf("%255[^\n]%*[^\n]", buffer) == EOF)
        {
            break;
        }
        // exitが入力されたらループを抜ける
        if (strstr(buffer, "exit") != NULL)
        {
            break;
        }
        // ある特定の文字が入力されたら異常終了させる
        if (strstr(buffer, "special keyword") != NULL)
        {
            return 1;
        }
        scanf("%*c");
        printf("> %s\n", buffer);
    }
    printf("---heredoc end---\n");

    // ファイル読み込み
    char fname[64];
    sscanf(getfilepath(), "%s", &fname);
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