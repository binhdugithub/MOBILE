if(SCREEN_HEIGHT <= 400)
{
    frm.size.height = 32;
}
else if (SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720)
{
    frm.size.height = 50;
}
else if(SCREEN_HEIGHT > 720)
{
    frm.size.height = 90;
}
