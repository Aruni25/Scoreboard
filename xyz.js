function uname()
{
    x=document.getElementById("t1").value;
    if(x.length<3)
    {
        document.getElementById("s1").innerHTML="Invalid name";
        return false;
    }
    return true;
}
function upass()
{
    x=document.getElementById("t2").value;
    if(x.length<3)
    {
        document.getElementById("s2").innerHTML="Invalid pass";
        return false;
    }
    return true;
}
function demo()
{
    x=document.getElementById("s1").innerHTML=" ";
    x=document.getElementById("s2").innerHTML=" ";
if(uname() && upass())
{
    form1.submit();
}
}