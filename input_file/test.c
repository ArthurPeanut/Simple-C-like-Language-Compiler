int main(){

	int a, b;
	a = 1;
	b = 0;
	if (a < 5) {
	    print("a < 5");
	} else {
	    print("a >= 5");
	}
	while (a < 5) {
	    a = a + 1;
	    b = b + 2;
	}
	print("b=%d", b);
	return 0;
}
