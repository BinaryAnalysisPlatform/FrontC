void main()
{
	goto lab1;
	x++;
	y--;
	lab1: ;
	
	lab2: ;
	x++;
	y--;
	goto lab2;
	
	if(x)
		goto lab3;
	else
		lab3: x++;
	
	if(x)
		lab4: x++;
	else
		goto lab4;
}
