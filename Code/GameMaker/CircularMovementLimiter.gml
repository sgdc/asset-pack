//horizSpeed and vertSpeed can be set either to the gamepad movement axes or to -1 or 1 depending on keydown
//to go faster than 1 multiply deltaX and deltaY after the fact, I believe.


//Limit movement to circle
if (sqrt(sqr(horizSpeed) + sqr(vertSpeed)) < 1)
{
    deltaX = horizSpeed;
    deltaY = vertSpeed;
}
else if (horizSpeed != 0 or vertSpeed != 0)
{
    deltaX = horizSpeed / sqrt((horizSpeed * horizSpeed) + (vertSpeed * vertSpeed));
    deltaY = vertSpeed / sqrt((horizSpeed * horizSpeed) + (vertSpeed * vertSpeed));
}
else
{
    deltaX = 0;
    deltaY = 0;
}

//at this point, multiply deltaX and deltaY if you want to change magnitude, if desired
//deltaX and deltaY are now the distance you want to move in X and Y
