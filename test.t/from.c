void main()
{
	if(x) goto lab1; else y();
	lab1: ;
	
	while(x) goto lab2;
	lab2: ;
	
	for(i = 0; i < 5; i++)
		goto lab3;
	lab3: ;
	
	{
		int a;
		goto lab4;
		x++;
		y++;
	}
	lab4: ;
}
