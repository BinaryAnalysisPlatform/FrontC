void main()
{
	switch(c)
	{
	case 0 : f();
	case 1 : g(); h(); break;
	case 2 : case 3 :
		f(); 
		if(x) {return; break;} else break;
		h();
		break;
	case 4 : j(); h(); break;
	case 5: break;
	default: break;
	}
}

/*void f()
{
	goto lab;
	switch(c)
	{
	case 0 : break;
	case 1 : break;
	default:
		f();
		if(d)
			lab: g();
		break;
	}
}*/
