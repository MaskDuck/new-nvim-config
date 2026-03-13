local text = [[
#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

#define REP(i,a,b) for (int (i) = (a); (i) <= (b); (i)++)
#define MASK(i) (1 << (i))
#define ALL(v) (v).begin(), (v).end()
#define SZ(x) (int)(x).size()
#define pb push_back

const int maxn = ...;

int main() {

}
]]
local text_to_put = vim.split(text, "\n")
local function cp_init()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row - 1, row + #text_to_put, false, text_to_put)
end

vim.api.nvim_create_user_command(
	"CPInit",
	cp_init,
	{ desc = '' }
)
