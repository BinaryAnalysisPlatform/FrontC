void main()
{
	goto lab1;
	if(x)
		lab1: f();
	else
		g();
	
	goto lab2;
	if(x)
		f();
	else
		lab2: g();
	
	goto lab3;
	while(x)
		lab3: h();
	
	goto lab4;
	do lab4: h(); while(x);
	
	goto lab5;
	{
		int a;
		h();
		lab5: f();
		g();
	}
}
