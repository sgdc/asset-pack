//horizSpeed and vertSpeed can be set either to the gamepad movement axes or to -1 or 1 depending on keydown
//to go faster than 1 multiply accelX and accelY after the fact, I believe.


//Limit movement to circle
if (sqrt(sqr(horizSpeed) + sqr(vertSpeed)) < 1)
{
    accelX = horizSpeed;
    accelY = vertSpeed;
}
else if (horizSpeed != 0 or vertSpeed != 0)
{
    accelX = horizSpeed / sqrt((horizSpeed * horizSpeed) + (vertSpeed * vertSpeed));
    accelY = vertSpeed / sqrt((horizSpeed * horizSpeed) + (vertSpeed * vertSpeed));
}
else
{
    accelX = 0;
    accelY = 0;
}
