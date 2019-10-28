#include <iostream>
#include <cmath>
#include <vector>
#include <algorithm>

using namespace std;

long double
F (vector<long double> &x)
{

        long double prod_cot = 1.;
        for (auto n : x) {
                prod_cot /= tan(pow(M_PI * n / 2., 2));
        }
        //cout << prod_cot << " ";        

        long double sum_tan = 0.;
        for (long double n : x) {
                sum_tan += tan(pow(M_PI * n / 2., 2));
        }
        //cout << sum_tan << " ";

        long double prod_sin = 1.;
        for (long double n : x) {
                prod_sin *= sin(pow(M_PI * n / 2., 2));
        }
        //cout << prod_sin << " ";
        //cout << exp(- sum_tan - prod_cot / 128.) /  prod_sin << endl;
        return exp(- sum_tan - prod_cot / 128.) /  prod_sin;
}


int
main (void)
{
        int n;
        cin >> n;

        vector<long double> xi(10);
        long double sum = 0;
        for (int i1 = 0; i1 < n-1; ++i1){
        for (int i2 = 0; i2 < n-1; ++i2){
        for (int i3 = 0; i3 < n-1; ++i3){
        for (int i4 = 0; i4 < n-1; ++i4){
        for (int i5 = 0; i5 < n-1; ++i5){
        for (int i6 = 0; i6 < n-1; ++i6){
        for (int i7 = 0; i7 < n-1; ++i7){
        for (int i8 = 0; i8 < n-1; ++i8){
        for (int i9 = 0; i9 < n-1; ++i9){
        for (int i0 = 0; i0 < n-1; ++i0){
                xi[0] = (long double)(i0 + 1) / (n + 1);
                xi[1] = (long double)(i1 + 1) / (n + 1);
                xi[2] = (long double)(i2 + 1) / (n + 1);
                xi[3] = (long double)(i3 + 1) / (n + 1);
                xi[4] = (long double)(i4 + 1) / (n + 1);
                xi[5] = (long double)(i5 + 1) / (n + 1);
                xi[6] = (long double)(i6 + 1) / (n + 1);
                xi[7] = (long double)(i7 + 1) / (n + 1);
                xi[8] = (long double)(i8 + 1) / (n + 1);
                xi[9] = (long double)(i9 + 1) / (n + 1);
                //cout << sum << " + " << pow(M_PI / 2, 10) * (F(xi) / (pow(n, 10))) << " = ";
                long double f = pow(M_PI, 10) * (F(xi) / (pow(n, 10)));
                sum += (isinf(f)) ? 0 : f;
                cout << sum << endl;
                if (isinf(sum)) goto label;
        }
        }        
        }        
        }        
        }        
        }        
        }        
        }        
        }        
        }
label:
        long double integral = sum;
        cout << integral << endl;
        return 0;
}