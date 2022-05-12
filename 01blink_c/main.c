#define PIO_BASE	0x01c20800
#define PA_CFG0		0x00

#define PA_DATA		0x10

void delay(volatile unsigned int n)
{
	while(n--);
}

int main(int argc, char **argv)
{
	volatile unsigned int *rp;

	/* configure PA3 to GPIO Output mode */
	rp = (volatile unsigned int *)(PIO_BASE + PA_CFG0);
	*rp &= ~(7 << 12);
	*rp |= (1 << 12);

	/* load PA Data register's content */
	rp = (volatile unsigned int *)(PIO_BASE + PA_DATA);

	while(1){
		/* set PA3 to low */
		*rp &= ~(1 << 3);

		/* make a delay */
		delay(0x0000f000);

		/* set PA3 to high */
		*rp |= (1 << 3);

		/* make a delay */
		delay(0x0000f000);
	}

	return 0;
}
