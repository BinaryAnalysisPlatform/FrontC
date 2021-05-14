int main(void )
{
	double _Complex z1 = 0.0 + __builtin_inff() * _Imaginary_I;
	double _Complex z2 = 0.0 + __builtin_inff() * 1.0iF;
	printf("z1 = %.1f%+.1fi\n", creal(z1), cimag(z1));
	printf("z2 = %.1f%+.1fi\n", creal(z2), cimag(z2));
}
