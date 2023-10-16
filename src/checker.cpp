#include <algorithm>
#include <iostream>
#include <fstream>
#include <string>
#include <cmath>

#define LINES 201

using namespace std;

double percentage_error(string s1, string s2) {
    double d1 = stod(s1);
    double d2 = stod(s2);

    if (isnan(d1))
        return 100;
    if (d1 == d2)
        return 0;
    else
        return (d1 - d2) * 100 / d2;
}

void first12(string& s) {
    s.erase(remove(s.begin(), s.end(), '.'), s.end());
    s = s.substr(0, 12);
}

bool equal_to_12_decimals(string s1, string s2) {
    first12(s1);
    first12(s2);
    return s1 == s2;
}

//Receives the expected output from cin
int main() {
    ifstream output;
    output.open("cp_output.txt");

    istream& expected = cin;

    string s1, s2;
    getline(output, s1); //ignore first line
    getline(expected, s2);

    double per_error = 0;
    bool valid = true;

    for (int i = 0; i < LINES; i++) { //TODO: dynamically detect/calculate number of lines
        output >> s1;   //ignore first column (time)
        expected >> s2;
        
        for (int j = 1; j < 6; j++) {
            output >> s1;
            expected >> s2;

            per_error += abs(percentage_error(s1, s2));
            valid &= equal_to_12_decimals(s1, s2);
        }
    }

    per_error /= LINES;

    cout << (valid ? "The output is valid (equal up to 12 decimal places)"
                   : "The output is not valid (difers in the first 12 decimal places)") << endl;
    cout << "Average Percentage Error: " << per_error << "%" << endl;
}