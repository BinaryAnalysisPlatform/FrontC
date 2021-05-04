void main()
{
	if(x)
		goto l;
	for(i = 0; i < 10; i++)
	{
		x--;
		l: f();
		g();
	}
}
