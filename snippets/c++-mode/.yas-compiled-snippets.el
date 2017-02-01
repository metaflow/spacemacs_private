;;; Compiled snippets and support files for `c++-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c++-mode
                     '(("prime_test" "// Miller-Rabin primality test | mult_mod, random\nbool primality_test(l n, l trials) {\n  auto complex_test = [] (l a, l n) {\n    l c = n - 1;\n    l m = 1;\n    l k = 0;\n    while (c >= m) {\n      k++;\n      m <<= 1;\n    }\n    m >>= 1;\n    l d = 1;\n    for (l i = 0; i < k; i++) {\n      l x = d;\n      d = mult_mod(d, d, n);\n      if (d == 1 && x != 1 && x != n - 1) return true;\n      if (c & m) d = mult_mod(d, a, n);\n      m >>= 1;\n    }\n    return (d != 1);\n  };\n\n  for (l i = 0; i < trials; i++) {\n    l a = random_in_range(2, n - 1);\n    if (complex_test(a, n)) return false;\n  }\n  return true;\n}\n" "Miller-Rabin primality test" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_primaity_test" nil nil)
                       ("powmod" "// (base^power) % mod, safe for l near max\nl pow_mod(l base, l power, l mod) {\n  l r = 1;\n  while (power) {\n    if (power % 2) r = mult_mod(r, base, mod);\n    base = mult_mod(base, base, mod);\n    power /= 2;\n  }\n  return r;\n}\n" "(base^power) % mod" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_pow_mod" nil nil)
                       ("multmod" "// (a * b) % mod, safe for l near max\nl mult_mod(l a, l b, l mod) {\n  l x = 0;\n  while (b) {\n    if (b % 2) x = (x + a) % mod;\n    a = (a * 2) % mod;\n    b /= 2;\n  }\n  return x;\n}\n" "multiplication modulo safe for near max" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_mult_mod" nil nil)
                       ("min cost max flow" "struct node;\nstruct edge;\nusing pnode = shared_ptr<node>;\nusing pedge = shared_ptr<edge>;\nusing graph = vector<pnode>;\n\nstruct node {\n  bool in_queue;\n  l potential;\n  vector<pedge> adjusted;\n  pedge back;\n};\n\nstruct edge {\n  pnode from, to;\n  l capacity, original_capacity;\n  l cost, original_cost;\n  pedge opposite;\n\n};\n\nvoid connect(pnode &a, pnode &b, l w, l cost) {\n  pedge ea = make_shared<edge>();\n  pedge eb = make_shared<edge>();\n  ea->from = a; ea->to = b; ea->capacity = ea->original_capacity = w;\n  ea->cost = ea->original_cost = cost; ea->opposite = eb;\n  eb->from = b; eb->to = a; eb->capacity = eb->original_capacity = 0;\n  eb->cost = eb->original_cost = 0; eb->opposite = ea;\n  a->adjusted.emplace_back(ea);\n  b->adjusted.emplace_back(eb);\n}\n\nvoid sssp(pnode start, graph& g) {\n  for (auto u : g) {\n    u->potential = INF;\n    u->in_queue = false;\n    u->back = NULL;\n  }\n  queue<pnode> q;\n  start->potential = 0;\n  start->in_queue = true;\n  q.emplace(start);\n  while (!q.empty()) {\n    auto u = q.front(); q.pop();\n    u->in_queue = false;\n    for (auto e : u->adjusted) {\n      if (e->capacity == 0) continue;\n      auto v = e->to;\n      l t = u->potential + e->cost;\n      if (t >= v->potential) continue;\n      v->potential = t;\n      v->back = e;\n      if (v->in_queue) continue;\n      v->in_queue = true;\n      q.emplace(v);\n    }\n  }\n  // update potentials\n  for (auto u : g) {\n    for (auto e : u->adjusted) {\n      if (e->capacity == 0) continue;\n      e->cost += e->from->potential - e->to->potential;\n    }\n  }\n}\n\nl min_cost_max_flow(graph& g, pnode s, pnode t) {\n  while (true) {\n    sssp(s, g);\n    if (t->potential == INF) break;\n    // augment\n    stack<pedge> a;\n    l m = INF;\n    auto u = t;\n    while (u->back) {\n      a.push(u->back);\n      m = min(m, u->back->capacity);\n      u = u->back->from;\n    }\n    while (!a.empty()) {\n      auto e = a.top(); a.pop();\n      e->capacity -= m;\n      e->opposite->capacity += m;\n    }\n  }\n  l cost = 0;\n  for (auto u : g) {\n    for (auto e : u->adjusted) {\n      cost += (e->original_capacity - e->capacity) * e->original_cost;\n    }\n  }\n  return cost;\n}\n" "find min-cost max-flow in directed graph with no negative cycles" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_min_cost_max_flow" nil nil)
                       ("matrix_power" "vvl matrix_power(vvl m, l power) {\n  l n = m.size();\n  vvl o(n);\n  for (l i = 0; i < n; i++) { o[i].resize(n); o[i][i] = 1; }\n  while (power) {\n    if (power % 2) o = matrix_multiply(o, m);\n    m = matrix_multiply(m, m);\n    power /= 2;\n  }\n  return o;\n}\n" "matrix power (log n)" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_matrix_power" nil nil)
                       ("matrix_mult" "vvl matrix_multiply(vvl a, vvl b) {\n  l n = a.size();\n  l k = b.size();\n  l m = b[0].size();\n  vvl c(n);\n  for (l i = 0; i < n; i++) c[i].resize(m);\n  for (l i = 0; i < n; i++) {\n    for (l j = 0; j < m; j++) {\n      for (l q = 0; q < k; q++) {\n        c[i][j] = (c[i][j] + a[i][q] * b[q][j]);\n      }\n    }\n  }\n  return c;\n}\n" "matrix multiplication" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_matrix_multiply" nil nil)
                       ("inverse_mod" "// return b: a * b = 1 (mod n)\nl inverse_mod(l a, l n) {\n  l x, y;\n  l d = extended_euclid(a, n, x, y);\n  if (d != 1) return 0;\n  return (x + (abs(x) / n + 1) * n) % n;\n}\n" "inverse modulo" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_inverse_mod" nil nil)
                       ("ff" "for (l ${3:i} = 0; $3 < ${2:n}; $3++) {\n  $0\n}\n" "for i in [0..n)" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_for_loop_int" nil nil)
                       ("fl" "for (l ${2:i} = 0; $2 < ${1:n}; $2++) $0;\n" "one line for" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_fl" nil nil)
                       ("factorize_big" "// factorize to primes with pollard_rho function\n// primes up to pow(max, 1/3)\nvl probablity_factorization(l n, vl& primes) {\n  auto pollard_rho = [](l n) -> l {\n    l i = 0, k = 2;\n    l x = 3, y = 3;\n    l d = 1;\n    while (d == 1) {\n      i++;\n      x = (mult_mod(x, x, n) + 1) % n;\n      d = gcd(abs(x - y), n);\n      if (i == k) { y = x; k *= 2; }\n    }\n    return d;\n  };\n  vl factors = factorize_to_primes(n, primes);\n  n = factors.back(); factors.pop_back();\n  if (!primality_test(n, 3)) {\n    l f = pollard_rho(n);\n    factors.emplace_back(f);\n    n /= f;\n  }\n  if (n != 1) factors.emplace_back(n);\n  return factors;\n}\n" "probability factorization of big number" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_factorize_big" nil nil)
                       ("fi" "for (l ${3:i} = 1; $3 <= ${2:n}; $3++) {\n  $0\n}\n" "inclusive for in [1, n]" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_f1" nil nil)
                       ("extended euclid" "// return gcd(a, b) and set x, y: a * x + b * y = gcd(a, b)\nl extended_euclid(l a, l b, l& x, l& y) {\n  if (b == 0) { x = 1; y = 0; return a; }\n  l d = extended_euclid(b, a % b, x, y);\n  l t = y;\n  y = x - (a / b) * y;\n  x = t;\n  return d;\n}\n" "solves extended eucledian equation" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_extended_euclid" nil nil)
                       ("rnd" "default_random_engine source(chrono::system_clock::now().time_since_epoch().count());\n\nl random_in_range(l a, l b) {\n  return uniform_int_distribution<l>(a, b)(source);\n}\n\nbool random_bool() {\n  return random_in_range(0, 1) == 1;\n}\n\nstring random_string(int length) {\n  string s = \"\";\n  string an = \"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\";\n  for (int i = 0; i < length; i++) {\n    s += an[random_in_range(0, an.size() - 1)];\n  }\n  return s;\n}\n" "random functions" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_etc_random" nil nil)
                       ("quadeq" "// real roots of axx + bx + c = 0\nvd quadratic_equation(double a, double b, double c) {\n  vd _;\n  double d = b * b - 4 * a * c;\n  if (d < 0) return _;\n  d = sqrt(d);\n  double x1 = (-b - d) / 2 / a;\n  double x2 = (-b + d) / 2 / a;\n  _.emplace_back(x1);\n  if (x2 != x1) _.emplace_back(x2);\n  return _;\n}\n" "qaudratic (square) equation real roots" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_etc_quadratic_equation" nil nil)
                       ("print_range" "template <typename Iterator>\nostream& print_range(ostream& s, const Iterator a, const Iterator b) {\n  bool first = true;\n  for (auto i = a; i != b; i++) {\n    if (!first) s << \" \";\n    first = false;\n    s << *i;\n  }\n  return s;\n}\n" "print range separated by space" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_etc_print_range" nil nil)
                       ("tcc" "int tcc; cin >> tcc;\nfor (int tc = 1; tc <= tcc; tc++) {\n  $0\n  l answer = 0;\n  cout << \"Case #\" << tc << \": \" << answer << endl;\n}\n" "problem with several subproblems" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_etc_n_cases" nil nil)
                       ("matrixmodmult" "vvl matrix_multiply(vvl a, vvl b, l mod) {\n  l n = a.size();\n  l k = b.size();\n  l m = b[0].size();\n  vvl c(n);\n  for (l i = 0; i < n; i++) c[i].resize(m);\n  for (l i = 0; i < n; i++) {\n    for (l j = 0; j < m; j++) {\n      for (l q = 0; q < k; q++) {\n        c[i][j] = (c[i][j] + a[i][q] * b[q][j]) % mod;\n      }\n    }\n  }\n  return c;\n}\n" "matrix multiplication modulo" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_etc_matrix_multiply_mod" nil nil)
                       ("eqdouble" "bool equal_double(double x, double y, double epsilon) {\n  if (abs(x - y) < epsilon) return true;\n  // Is x or y too close to zero?\n  if (abs(x) < epsilon || abs(y) < epsilon) return false;\n  // Check relative precision.\n  return (abs((x - y) / x) < epsilon) && (abs((x - y) / y) < epsilon);\n}\n" "equality of real numbers" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_etc_equal_double" nil nil)
                       ("az" "abcdefghijklmnopqrstuvwxyz\n" "english alphabet" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_etc_az" nil nil)
                       ("uds" "struct disjoint_set { // set of [0..n-1]\n  vl parent;\n  l components_count_;\n\n  disjoint_set(size_t n) {\n    components_count_ = n;\n    parent.resize(n);\n    for (size_t i = 0; i < n; i++) parent[i] = i;\n  }\n  l get_parent(l i) {\n    if (parent[i] != i) parent[i] = get_parent(parent[i]);\n    return parent[i];\n  }\n  bool connected(l i, l j) { return get_parent(i) == get_parent(j); }\n   void connect(l i, l j) {\n    i = get_parent(i);\n    j = get_parent(j);\n    if (i != j) {\n      parent[i] = j;\n      components_count_--;\n    }\n  }\n  l components_count() { return components_count_; }\n};\n" "union-disjoint set" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_ds_union_disjoint_set" nil nil)
                       ("fenwick" "// RSQ for range [1, n]\nstruct fenwik_tree {\n  vl tree;\n  l max_p;\n  fenwik_tree(size_t n) {\n    max_p = n;\n    tree.resize(n + 1);\n  };\n  // sum of [1, p], O(log(max))\n  l read(l p) {\n    l sum = 0;\n    while (p) {\n      sum += tree[p];\n      p -= (p & -p);\n    }\n    return sum;\n  }\n  // O(log(max))\n  void add(l p, l value) {\n    while (p <= max_p) {\n      tree[p] += value;\n      p += (p & -p);\n    }\n  }\n  // find lowest index with given sum, -1 if not found O(log(max))\n  l find(l sum) {\n    l mask = max_p;\n    while (true) {\n      l lower = (mask & -mask);\n      if (lower == mask) break;\n      mask -= lower;\n    }\n    l p = 0;\n    l top = -1;\n    while (mask != 0) {\n      l m = p + mask;\n      if (m <= max_p) {\n        if (sum == tree[m]) top = m;\n        if (sum > tree[m]) {\n          p = m;\n          sum -= tree[m];\n        }\n      }\n      mask >>= 1;\n    }\n    if (sum != 0) return top;\n    return p;\n  }\n};\n" "Fenwick tree for range sum queries" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_ds_fenwik_tree" nil nil)
                       ("bigint" "struct bigint {\n  static const l BUCKET = 1000;\n  static const int BUCKET_DIGITS = 3;\n  vl buckets;\n  // constructors\n  bigint() {}\n  bigint(l a) {\n    buckets.emplace_back(a);\n    normalize();\n  }\n  bigint(const bigint& n) { buckets = n.buckets; }\n  bigint(bigint&& n) : bigint() { swap(*this, n); }\n  friend void swap(bigint& first, bigint& second) {\n    swap(first.buckets, second.buckets);\n  }\n  // assignment\n  bigint& operator = (l a) {\n    buckets.clear();\n    buckets.emplace_back(a);\n    normalize();\n    return *this;\n  }\n  bigint& operator = (bigint rhs) {\n    swap(*this, rhs);\n    return *this;\n  }\n  // utility\n  void normalize() {\n    size_t i = 0;\n    while (i < buckets.size()) {\n      l t = buckets[i] / BUCKET;\n      if (t) {\n        if (i + 1 == buckets.size()) buckets.resize(i + 2);\n        buckets[i + 1] += t;\n        buckets[i] %= BUCKET;\n      }\n      i++;\n    }\n  }\n  size_t size() {\n    if (buckets.empty()) return 0;\n    size_t r = BUCKET_DIGITS * (buckets.size() - 1) + 1;\n    l b = buckets.back();\n    while (b >= 10) {\n      r++;\n      b /= 10;\n    }\n    return r;\n  }\n  friend ostream& operator << (ostream& s, bigint& n) {\n    for (auto i = n.buckets.rbegin(); i != n.buckets.rend(); i++) {\n      s << *i << setw(BUCKET_DIGITS) << setfill('0');\n    }\n    s << setw(0);\n    return s;\n  }\n  // +\n  friend bigint operator + (bigint lhs, const bigint &rhs) {\n    lhs += rhs;\n    return lhs;\n  }\n  bigint& operator += (const bigint& rhs) {\n    size_t n = rhs.buckets.size();\n    if (n > buckets.size()) buckets.resize(n);\n    for (size_t i = 0; i < min(buckets.size(), n); i++) {\n      buckets[i] += rhs.buckets[i];\n    }\n    normalize();\n    return *this;\n  }\n  bigint& operator += (const l n) {\n    buckets[0] += n;\n    normalize();\n    return *this;\n  }\n  friend bigint operator + (bigint lhs, const l &rhs) {\n    lhs += rhs;\n    return lhs;\n  }\n  // *\n  bigint& operator *= (const l n) {\n    for (size_t i = 0; i < buckets.size(); i++) {\n      buckets[i] *= n;\n    }\n    normalize();\n    return *this;\n  }\n  friend bigint operator * (bigint lhs, const l &rhs) {\n    lhs *= rhs;\n    return lhs;\n  }\n  bigint& operator *= (const bigint& rhs) {\n    bigint a;\n    bigint m(*this);\n    for (int i = 0; i < b.buckets.size(); i++) {\n      a += (m * b.buckets[i]);\n      a.normalize();\n      m.buckets.insert(m.buckets.begin(), 0); // * 10\n    }\n    swap(a, *this);\n    return *this;\n  }\n};\n" "big integer" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_ds_bigint" nil nil)
                       ("3d" "struct point {\n  double x, y, z;\n  point() {}\n  point(double x, double y, double z) : x(x), y(y), z(z) {}\n  // scalar multiplication\n  double operator * (const point & o) {\n    return x * o.x + y * o.y + z * o.z;\n  }\n  // vector multiplication\n  point operator ^ (const point & o) {\n    return point(y * o.z - z * o.y,\n                -x * o.z + z * o.x,\n                 y * o.x - x * o.y);\n  }\n  point operator - (const point& o) {\n    return point(x - o.x, y - o.y, z - o.z);\n  }\n  point operator + (const point& o) {\n    return point(x + o.x, y + o.y, z + o.z);\n  }\n  // distance between points\n  double operator >> (const point& o) {\n    point d = (*this - o);\n    return sqrt(d * d);\n  }\n};\n\npoint polar_to_point(double r, double la, double lo) {\n  return point(r * cos(la) * cos(lo), r * cos(la) * sin(lo), r * sin(la));\n}\n\nostream& operator << (ostream& s, const point& p) {\n  s << \"(\" << p.x << \", \" << p.y << \", \" << p.z << \")\";\n  return s;\n}\n" "3d point" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_ds_3d" nil nil)
                       ("2d" "struct point {\n  ${1:double} x, y;\n  point() {}\n  point($1 x, $1 y) : x(x), y(y) {}\n  // scalar multiplication\n  $1 operator * (const point & o) {\n    return x * o.x + y * o.y;\n  }\n  point operator * (const $1 m) {\n    return point(x * m, y * m);\n  }\n  // vector multiplication\n  $1 operator ^ (const point & o) {\n    return x * o.y - y * o.x;\n  }\n  point operator - (const point& o) {\n    return point(x - o.x, y - o.y);\n  }\n  point operator + (const point& o) {\n    return point(x + o.x, y + o.y);\n  }\n  // squared distance\n  double operator >> (const point& o) {\n    point d = (*this - o);\n    return d * d;\n  }\n  double distance(const point& o) {\n    return sqrt(*this >> o);\n  }\n  const bool operator < (const point& o) const {\n    if (o.x != x) return x < o.x;\n    return y < o.y;\n  }\n};\n\nostream& operator << (ostream& s, const point& p) {\n  s << \"(\" << p.x << \", \" << p.y << \")\";\n  return s;\n}\n" "2d operations" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_ds_2d" nil nil)
                       ("graph" "struct node;\nstruct edge;\nusing pnode = shared_ptr<node>;\nusing pedge = shared_ptr<edge>;\nusing graph = vector<pnode>;\n\nstruct node {\n  bool visited;\n  vector<pedge> adjusted;\n  pedge back;\n};\n\nstruct edge {\n  pnode from, to;\n  int flow;\n  pedge opposite;\n};\n\nvoid connect(pnode &a, pnode &b, int w) {\n  pedge ea = make_shared<edge>();\n  pedge eb = make_shared<edge>();\n  ea->from = a; ea->to = b; ea->flow = w; ea->opposite = eb;\n  eb->from = b; eb->to = a; eb->flow = 0; eb->opposite = ea;\n  a->adjusted.emplace_back(ea);\n  b->adjusted.emplace_back(eb);\n}\n" "directed graph with pointers" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_data_graph_pointers" nil nil)
                       ("cp_circumscribed_circle" "tuple<point, bool> circumscribed_circle(point a, point b, point c) {\n  point ac = c - a;\n  point ab = b - a;\n  point bc = c - b;\n  if ((ab * ac < 0) || (ab * bc > 0) || (ac * bc < 0)) {\n    return make_tuple(point(), false);\n  }\n  if (abs(ab ^ ac) < 1e-8) { // line\n    return make_tuple(point(), false);\n  }\n  point x(ac.y, -ac.x);\n  point y(ab.y, -ab.x);\n  point e = a + (ac * 0.5);\n  point d = a + (ab * 0.5);\n  point z = d - e;\n  double w = - (x ^ z) / (x ^ y);\n  point o = d + (y * w);\n  return make_tuple(o, true);\n}\n" "circumscribed circle position" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_circumscribed_circle" nil nil)
                       ("bsl" "// finds lowest x: f(x) = true, x within [a, b) f(b) = true\n${1:l} binary_search_lower($1 a, $1 b, function<bool($1)> f) {\n  $1 step = b - a;\n  while (step > 0) {\n    step /= 2;\n    $1 m = a + step;\n    if (!f(m)) a = m + 1;\n  }\n  return a;\n}\n" "binary search lower" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_binary_search_lower" nil nil)
                       ("tsp" "// IDA* TSP with bitmask up to 64 vertices\nl ida_updated_bound;\nl estimate(int root, lu visited, vvi& distances) {\n  l e = 0;\n  for (size_t i = 0; i < distances.size(); i++) {\n    if (visited & (1ull << i)) continue;\n    if (distances[root][i] > e) e = distances[root][i];\n  }\n  return e;\n}\n\nbool tsp_dfs(int position, lu visited, l traveled,\n             l bound, vvi& distances) {\n  l e = estimate(position, visited, distances) + traveled;\n  if (e > bound) {\n    ida_updated_bound = min(ida_updated_bound, e);\n    return false;\n  }\n  if (visited + 1 == (1ull << (distances.size()))) return true;\n  for (size_t i = 0; i < distances.size(); i++) {\n    if (visited & (1ull << i)) continue;\n    if (tsp_dfs(i, visited | (1ull << i), traveled + distances[position][i],\n                bound, distances)) return true;\n  }\n  return false;\n}\n\nl tsp(vvi& distances) {\n  l bound = estimate(0, 1, distances);\n  while (bound != INF) {\n    ida_updated_bound = INF;\n    if (tsp_dfs(0, 1, 0, bound, distances)) break;\n    bound = ida_updated_bound;\n  }\n  return bound;\n}\n" "traveling salesman problem of up to 64 nodes IDA*" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_tsp" nil nil)
                       ("scc" "struct node;\nstruct edge;\nusing pnode = shared_ptr<node>;\nusing pedge = shared_ptr<edge>;\nusing graph = vector<pnode>;\n\nstruct node {\n  bool visited;\n  bool in_stack;\n  int age, reachable;\n  vector<pedge> forward;\n  //vector<pedge> backward;\n};\n\nstruct edge {\n  pnode from, to;\n};\n\nvoid connect(pnode a, pnode b) {\n  pedge e = make_shared<edge>();\n  e->from = a; e->to = b;\n  a->forward.emplace_back(e);\n  //b->backward.emplace_back(e);\n}\n\nvoid scc_dfs(pnode u, int& age, stack<pnode>& s) {\n  age++;\n  u->age = u->reachable = age;\n  u->visited = true;\n  s.push(u);\n  u->in_stack = true;\n  for (auto e : u->forward) {\n    auto v = e->to;\n    if (!v->visited) scc_dfs(v, age, s);\n    if (v->in_stack) u->reachable = min(u->reachable, v->reachable);\n  }\n  if (u->age == u->reachable) {\n    while (true) {\n      // do something\n      auto v = s.top(); s.pop();\n      v->in_stack = false;\n      if (u == v) break;\n    }\n  }\n}\n\nvoid find_scc(graph& g) {\n  int age = 0;\n  for (auto u : g) {\n    if (u->visited) continue;\n    stack<pnode> s;\n    scc_dfs(u, age, s);\n  }  \n}\n" "strongly connected components of directed graph" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_strongly_connected_components" nil nil)
                       ("sssp" "// adj[u][?] = (v, x) - edge from u to v of weight x\nvl shortest_paths(int from, vector<vector<ii>>& adj) {\n  size_t n = adj.size();\n  vl distance(n, INF);\n  queue<size_t> q;\n  vb in_queue(n, false);\n  distance[from] = 0;\n  q.emplace(from);\n  while (!q.empty()) {\n    size_t u = q.front(); q.pop(); in_queue[u] = false;\n    for (auto e : adj[u]) {\n      int v = e.first;\n      int d = e.second;\n      l t = distance[u] + d;\n      if (t < distance[v]) {\n        distance[v] = t;\n        if (!in_queue[v]) {\n          q.emplace(v);\n          in_queue[v] = true;\n        }\n      }\n    }\n  }\n  return distance;\n}\n" "single source shortest paths (~Dijkstra)" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_sssp" nil nil)
                       ("sign" "l sign(l n) {\n  if (n < 0) return -1;\n  if (n == 0) return 0;\n  return 1;\n}\n" "sign of int" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_sign" nil nil)
                       ("sieve" "const l MAX_PRIME = 1000000;\nvl sieve_primes() {\n  bitset<MAX_PRIME + 1> b;\n  vl primes;\n  primes.emplace_back(2);\n  for (l i = 3; i <= MAX_PRIME; i += 2) {\n    if (b[i]) continue;\n    primes.emplace_back(i);\n    for (l j = i * i; j <= MAX_PRIME; j += i) b.set(j);\n  }\n  return primes;\n}\n" "sieve primes" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_sieve_primes" nil nil)
                       ("blossom" "// unweigted max graph matching (Edmind's blossom algorithm)\n// to filter edges modify node#out method\nnamespace unweighted_max_matching {\n  struct node;\n  struct edge;\n  using pnode = shared_ptr<node>;\n  using pedge = shared_ptr<edge>;\n  using graph = vector<pnode>;\n\n  l _edge_id = 0;\n  struct edge {\n    pnode _to;\n    pedge opposite;\n    bool matched, visited;\n    l id;\n    pnode to();\n    pnode from() { return opposite->to(); }\n    void match(bool v);\n    void visit(bool v) { visited = v; opposite->visited = v; }\n  };\n  l _node_id;\n  struct node {\n    l id, age, tree_no, blossom_id;\n    bool exposed;\n    vector<pedge> adjusted;\n    pedge back, matched;\n    pnode up;\n    vector<pnode> down;\n    vector<pedge> _out;\n    bool out_cached = false;\n    vector<pedge> out() {\n      if (!out_cached) {\n        _out.clear();\n        if (down.empty()) {\n          for (auto e : adjusted) {\n            // filter here\n            _out.emplace_back(e);\n          }\n        } else {\n          for (auto u : down) {\n            for (auto e : u->out()) {\n              auto v = e->to();\n              auto r = e->from();\n              if (v == r) continue;\n              _out.emplace_back(e);\n            }\n          }\n        }\n        out_cached = true;\n      }\n      return _out;\n    };\n    void reset() {\n      age = 0;\n      tree_no = 0;\n      back = NULL;\n      up = NULL;\n      out_cached = false;\n      down.clear();\n      for (auto e : adjusted) e->matched = false;\n    }\n    vector<pedge> path_to_root() {\n      if (!back) return vector<pedge>();\n      auto p = back->from()->path_to_root();\n      p.emplace_back(back);\n      return p;\n    }\n  };\n\n  pnode edge::to() {\n    auto t = _to;\n    while (t->up) t = t->up;\n    return t;\n  }\n\n  void edge::match(bool v) { matched = v; opposite->matched = v; }\n\n  void connect(pnode &a, pnode &b) {\n    pedge ea = make_shared<edge>();\n    pedge eb = make_shared<edge>();\n    _edge_id++;\n    ea->id = _edge_id; ea->_to = b; ea->opposite = eb;\n    eb->id = _edge_id; eb->_to = a; eb->opposite = ea;\n    a->adjusted.emplace_back(ea);\n    b->adjusted.emplace_back(eb);\n  }\n\n  vector<pedge> find_augmenting_path(graph& g);\n  l _blossom_id = 0;\n  vector<pedge> process_blossom(graph& g, const pedge connect) {\n    // create blossom\n    _blossom_id++;\n    l blossom_id = _blossom_id;\n    auto blossom = make_shared<node>();\n    blossom->id = _node_id++;\n    set<l> blossom_border;\n    blossom_border.insert(connect->id);\n    auto u = connect->from();\n    auto w = connect->to();\n    while (u != w) {\n      if (u->age < w->age) swap(u, w);\n      blossom->down.emplace_back(u);\n      blossom_border.insert(u->back->id);\n      u = u->back->from();\n    }\n    blossom->down.emplace_back(u);\n    for (auto v : blossom->down) {\n      v->up = blossom;\n      v->blossom_id = blossom_id;\n    }\n    // find augmented path with blossom\n    g.emplace_back(blossom);\n    auto path = find_augmenting_path(g);\n    g.pop_back();\n    // lift path: adding even-length path within blossom end-to-end or to exposed\n    pnode target;\n    for (auto v : blossom->down) {\n      v->up = NULL;\n      v->age = 0;\n      v->back = NULL;\n      if (v->exposed) target = v;\n    }\n    vector<pnode> border;\n    for (auto e : path) {\n      if (e->to()->blossom_id == blossom_id) border.emplace_back(e->to());\n      if (e->from()->blossom_id == blossom_id) border.emplace_back(e->from());\n    }\n    if (border.empty()) return path;\n    if (border.size() == 2) target = border[1];\n    queue<pnode> q;\n    q.emplace(border[0]);\n    border[0]->age = 1;\n    while (!q.empty()) {\n      auto u = q.front(); q.pop();\n      for (auto e : u->out()) {\n        if (blossom_border.count(e->id) == 0) continue;\n        auto v = e->to();\n        if (v->age != 0) continue;\n        if (v == target && u->age % 2 == 1) continue;\n        v->back = e;\n        v->age = u->age + 1;\n        q.emplace(v);\n      }\n    }\n    auto b = target->path_to_root();\n    path.insert(path.end(), b.begin(), b.end());\n    return path;\n  }\n\n  queue<pnode> get_exposed(graph& g) {\n    l tree_no = 1;\n    queue<pnode> q;\n    for (auto u : g) {\n      if (u->up) continue;\n      u->age = 0;\n      u->tree_no = 0;\n      u->back = NULL;\n      u->exposed = true;\n      for (auto e : u->out()) {\n        e->visit(false);\n        if (e->matched) {\n          u->exposed = false;\n          u->matched = e;\n        }\n      }\n      if (!u->exposed) continue;\n      u->tree_no = tree_no++;\n      q.emplace(u);\n    }\n    return q;\n  }\n\n  pnode add_to_tree(pedge e) {\n    //    e\n    // u --- v === w\n    auto u = e->from();\n    auto v = e->to();\n    v->back = e;\n    v->age = u->age + 1;\n    auto y = v->matched;\n    y->visit(true);\n    pnode w = y->to();\n    w->back = y;\n    w->age = u->age + 2;\n    v->tree_no = w->tree_no = u->tree_no;\n    return w;\n  }\n\n  vector<pedge> connect_trees(pedge e) {\n    vector<pedge> path;\n    path.emplace_back(e);\n    auto p = e->from()->path_to_root();\n    path.insert(path.end(), p.begin(), p.end());\n    p = e->to()->path_to_root();\n    path.insert(path.end(), p.begin(), p.end());\n    return path;\n  }\n\n  vector<pedge> find_augmenting_path(graph& g) {\n    queue<pnode> q = get_exposed(g);\n    vector<pedge> path;\n    while (!q.empty()) {\n      auto u = q.front(); q.pop();\n      for (auto e : u->out()) {\n        if (e->visited) continue;\n        e->visit(true);\n        auto w = e->to();\n        if (w->tree_no == 0) { q.emplace(add_to_tree(e)); continue; }\n        if (w->age % 2 == 1) continue;\n        if (w->tree_no != u->tree_no) return connect_trees(e);\n        return process_blossom(g, e);\n      }\n    }\n    return path;\n  }\n\n  l match(graph& g) {\n    for (auto u : g) u->reset();\n    while (true) {\n      auto p = find_augmenting_path(g);\n      if (p.empty()) break;\n      for (auto e : p) e->match(!e->matched);\n    }\n    l r = 0;\n    for (auto u : g) {\n      for (auto e : u->adjusted) {\n        if (e->matched) r++;\n      }\n    }\n    return r / 2;\n  }\n}\nusing namespace unweighted_max_matching;\n" "unweghted max graph matching (Edmond's blossom algorithm)" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_max_unweighted_graph_matching" nil nil)
                       ("maxflow" "// v max flow\nstruct node;\nstruct edge;\nusing pnode = shared_ptr<node>;\nusing pedge = shared_ptr<edge>;\nusing graph = vector<pnode>;\n\nstruct node {\n  int age;\n  vector<pedge> adjusted;\n  pedge back;\n};\n\nstruct edge {\n  pnode from, to;\n  int flow;\n  pedge opposite;\n};\n\nint adjust(pedge e, int d) {\n  if (!e) return d;\n  d = adjust(e->from->back, min(d, e->flow));\n  e->flow -= d;\n  e->opposite->flow += d;\n  return d;\n}\n\nvoid connect(pnode &a, pnode &b, int w) {\n  pedge ea = make_shared<edge>();\n  pedge eb = make_shared<edge>();\n  ea->from = a; ea->to = b; ea->flow = w; ea->opposite = eb;\n  eb->from = b; eb->to = a; eb->flow = 0; eb->opposite = ea;\n  a->adjusted.emplace_back(ea);\n  b->adjusted.emplace_back(eb);\n}\n\nint max_flow(vector<pnode> &g, pnode &source, pnode &sink) {\n  int result = 0;\n  while (true) {\n    for (auto u : g) u->age = 0;\n    queue<pnode> q;\n    q.push(source); source->age = 1;\n    while (!(q.empty() || sink->age != 0)) {\n      auto u = q.front(); q.pop();\n      for (auto e : u->adjusted) {\n        auto v = e->to;\n        if (v->age != 0 || e->flow == 0) continue;\n        v->back = e;\n        v->age = u->age + 1;\n        q.push(v);\n      }\n    }\n    if (sink->age == 0) break;\n    for (auto e : sink->adjusted) {\n      auto o = e->opposite;\n      if (o->from->age != sink->age - 1 || o->flow == 0) continue;\n      result += adjust(o, o->flow);\n    }\n  }\n  return result;\n} // ^ max flow \n" "maximum flow" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_max_flow" nil nil)
                       ("maxbipartite" "bool bipartite_matching_connect(const int u, vvb& m, vi& to, vb& used) {\n  for (size_t v = 0; v < to.size(); v++) {\n    if (!m[u][v] || used[v]) continue;\n    used[v] = true;\n    if (to[v] == -1 || bipartite_matching_connect(to[v], m, to, used)) {\n      to[v] = u;\n      return true;\n    }\n  }\n  return false;\n}\n\n// {A} => {B}, m[i][j] == A[i] -> B[j]\nint bipartite_matching(vvb& m) {\n  if (m.empty()) return 0;\n  vi to(m[0].size(), -1);\n  int result = 0;\n  for (size_t u = 0; u < m.size(); u++) {\n    vb used(to.size());\n    if (bipartite_matching_connect(u, m, to, used)) result++;\n  }\n  return result;\n}\n" "maximum bipartite matching" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_max_bipartite_matching" nil nil)
                       ("kmp" "vi kmp_build_back(string pattern) {\n  vi b(pattern.size());\n  size_t i = 0; int j = -1; b[0] = -1;\n  while (i < pattern.size()) {\n    while (j > -1 && pattern[j] != pattern[i]) j = b[j];\n    i++;\n    j++;\n    b[i] = j;\n  }\n  return b;\n}\n\nvi kmp_search(string pattern, string s, vi b) {\n  int j = 0;\n  vi matches;\n  for (size_t i = 0; i < s.size(); i++) {\n    while (j > -1 && pattern[j] != s[i]) j = b[j];\n    j++;\n    if (j == int(pattern.size())) {\n      matches.emplace_back(i - j + 1);\n      j = b[j];\n    }\n  }\n  return matches;\n}\n" "KMP substring search in O(n) (Knuth Morris Pratt)" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_kmp_search" nil nil)
                       ("intervals" "// intervals are inclusive [a, b]\n// e.g. [1, 2] + [2, 3] -> [1, 3]\n// [1, 4] - [2, 3] -> [1], [4]\n// and find([4, 7]) -> ([1, 4], [5, 6], [7, 11])\nclass interval_tree {\nprivate:\n  struct intervals_key {\n    bool operator() (const ii& a, const ii& b) {\n      return a.second < b.first;\n   };\n  };\n  set<ii, intervals_key> m;\n  friend ostream& operator << (ostream& s, const interval_tree& v) {\n    for (auto ii = v.m.cbegin(); ii != v.m.cend(); ii++) {\n      s << \"[\" << ii->first << \", \" << ii->second << \"] \";\n    }\n    return s;\n  }\npublic:\n  void add(int a, int b) {\n    vii r;\n    auto p = m.equal_range(make_pair(a, b));\n    for (auto ii = p.first; ii != p.second; ii++) r.emplace_back(*ii);\n    m.erase(p.first, p.second);\n    for (auto ii : r) {\n      a = min(a, ii.first);\n      b = max(b, ii.second);\n    }\n    m.emplace(make_pair(a, b));\n  }\n\n  void remove(int a, int b) {\n    auto p = m.equal_range(make_pair(a, b));\n    vii r;\n    for (auto ii = p.first; ii != p.second; ii++) r.emplace_back(*ii);\n    m.erase(p.first, p.second);\n    for (auto ii : r) {\n      if (ii.first < a) {\n        m.emplace(make_pair(ii.first, min(a, ii.second) - 1));\n      }\n      if (ii.second > b) {\n        m.emplace(make_pair(max(b, ii.first) + 1, ii.second));\n      }\n    }\n  }\n\n  vii find(int a, int b) {\n    vii r;\n    auto p = m.equal_range(make_pair(a, b));\n    for (auto i = p.first; i != p.second; i++) r.emplace_back(*i);\n    return r;\n  }\n\n  vii keys() {\n    vii r;\n    r.insert(r.begin(), m.cbegin(), m.cend());\n    return r;\n  }\n};\n" "interval tree" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_interval_tree" nil nil)
                       ("gcd" "l gcd(l a, l b) {\n  while (b) { l t = b; b = a % b; a = t; }\n  return a;\n}\n\nl lcm(l a, l b) { return a * b / gcd(a, b); }\n" "GCD and LCM" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_gcd_lcm" nil nil)
                       ("gaussian" "// straighforward Gaussian elimination O(n^3)\n// x + y = a    ->  [[1 1 a],\n// 2x + 1y = b  ->   [2 1 b]]\nvector<double> solve(vector<vd> m) {\n  l n = m.size();\n  for (l i = 0; i < n; i++) {\n    // find row from i with largest value at i\n    l tr = i;\n    for (l r = i + 1; r < n; r++) {\n      if (m[r][i] > m[tr][i]) tr = r;\n    }\n    // swap with row i\n    swap(m[i], m[tr]);\n    // eliminate i from all rows below\n    for (l r = i + 1; r < n; r++) {\n      for (l c = n; c >= i; c--) {\n        m[r][c] -= m[i][c] * m[r][i] / m[i][i]; // be carefull\n      }\n    }\n  }\n  vd result(n);\n  // restore\n  for (l i = n - 1; i >= 0; i--) {\n    double t = m[i][n];\n    for (l j = i + 1; j < n; j++) t -= m[i][j] * result[j];\n    t /= m[i][i]; // be carefull\n    result[i] = t;\n  }\n  return result;\n}\n" "solve equation system via gaussian elemination" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_gaussian_elimination" nil nil)
                       ("floodfill" "void flood_fill(vvl& M, l r, l c, l from_color, l to_color) {\n  const l dr[] = {1, -1, 0, 0};\n  const l dc[] = {0, 0, 1, -1};\n  queue<ll> q;\n  if (M.empty()) return;\n  l max_x = M.size();\n  l max_y = M[0].size();\n  M[r][c] = to_color;\n  q.emplace(r, c);\n  while (!q.empty()) {\n    auto p = q.front(); q.pop();\n    for (l i = 0; i < 4; i++) {\n      l x = p.first + dr[i];\n      l y = p.second + dc[i];\n      if (x < 0 || x >= max_x || y < 0 || y >= max_y) continue;\n      if (M[x][y] != from_color) continue;\n      M[x][y] = to_color;\n      q.emplace(x, y);\n    }\n  }\n}\n" "floodfill 2d matrix" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_flood_fill" nil nil)
                       ("fibn" "vl __fibonacci_m_pow(vl &a, l n, l mod) {\n  if (n == 1) return a;\n  vl r(4), m1, m2;\n  if (n % 2 == 0) {\n    m1 = m2 = __fibonacci_m_pow(a, n / 2, mod);\n  } else {\n    m1 = a;\n    m2 = __fibonacci_m_pow(a, n - 1, mod);\n  }\n  r[0] = (m1[0] * m2[0] + m1[1] * m2[2]) % mod;\n  r[1] = (m1[0] * m2[1] + m1[1] * m2[3]) % mod;\n  r[2] = (m1[2] * m2[0] + m1[3] * m2[2]) % mod;\n  r[3] = (m1[2] * m2[1] + m1[3] * m2[3]) % mod;\n  return r;\n}\n\n// n >= 1, {1, 1, 2, 3, 5, ...}\nl fibonacci(l n, l mod) {\n  vl a(4);\n  a[0] = 1; a[1] = 1; a[2] = 1; a[3] = 0;\n  auto r = __fibonacci_m_pow(a, n, mod);\n  return r[1];\n}\n" "O(log(n)) Fibonacci calculation" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_fibonacci" nil nil)
                       ("factorize" "vl factorize_to_primes(l n, vl& primes) {\n  vl factors;\n  auto p = primes.begin();\n  while (p != primes.end() && (*p) * (*p) <= n) {\n    while (n % *p == 0) {\n      factors.emplace_back(*p);\n      n /= *p;\n    }\n    p++;\n  }\n  if (n != 1) factors.emplace_back(n);\n  return factors;\n}\n" "factorize small integer to primes" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_factorize_to_primes" nil nil)
                       ("convextest" "// assumes no 3 points collinear\nbool convex(vector<point> &p) {\n  l s = (p[1] - p[0]) ^ (p[2] - p[0]);\n  for (l i = 1; i < p.size(); i++) {\n    int j = (i + 1) % p.size();\n    int k = (j + 1) % p.size();\n    if (s * ((p[j] - p[i]) ^ (p[k] - p[i])) < 0) return false;\n  }\n  return true;\n}\n" "test if 2d polygon is convex" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_check_polygon_convex" nil nil)
                       ("suffixarray" "void sort_suffix_array(vi& sa, vllu& rank, int k) {\n  int n = sa.size();\n  vi counts(max(n, 300));\n  for (int i = 0; i < n; i++) {\n    int p = 0;\n    if (i + k < n) p = rank[i + k];\n    counts[p]++;\n  }\n  int s = 0;\n  for (size_t i = 0; i < counts.size(); i++) {\n    int t = counts[i];\n    counts[i] = s;\n    s += t;\n  }\n  vi updated_sa(n);\n  for (auto i : sa) {\n    int p = 0;\n    if (i + k < n) p = rank[i + k];\n    updated_sa[counts[p]] = i;\n    counts[p]++;\n  }\n  swap(sa, updated_sa);\n}\n\nvi build_suffix_array(string s) {\n  size_t n = s.size();\n  vi sa(n);\n  vllu rank(n);\n  for (size_t i = 0; i < n; i++) {\n    rank[i] = s[i];\n    sa[i] = i;\n  }\n  for (size_t k = 1; k < n; k = k << 1) {\n    sort_suffix_array(sa, rank, k);\n    sort_suffix_array(sa, rank, 0);\n    vllu updated_rank(rank.size());\n    int r = 0;\n    updated_rank[sa[0]] = r;\n    for (size_t i = 1; i < n; i++) {\n      if (rank[sa[i]] != rank[sa[i - 1]] ||\n          rank[sa[i] + k] != rank[sa[i - 1] +k]) r++;\n      updated_rank[sa[i]] = r;\n    }\n    swap(rank, updated_rank);\n    if (rank[sa[n - 1]] == n - 1) break;\n  }\n  return sa;\n}\n\nvi build_lcp(string &s, vi &sa) {\n  size_t i;\n  vi lcp(sa.size()), plcp(sa.size());\n\n  vi p(sa.size());\n  p[sa[0]] = -1;\n  for (i = 1; i < sa.size(); ++i) p[sa[i]] = sa[i - 1];\n  int w = 0;\n  for (i = 0; i < sa.size(); ++i) {\n    if (p[i] == -1) { plcp[i] = 0; continue; }\n    while (s[i + w] == s[p[i] + w] && i + w + 1 < sa.size()) w++;\n    plcp[i] = w;\n    if (w) --w;\n  }\n  for (i = 0; i < sa.size(); ++i) {\n    lcp[i] = plcp[sa[i]];\n  }\n  return lcp;\n}\n" "O(n log(n)) suffix array and longest common profix calculation" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/cp_alg_build_suffix_array" nil nil)))


;;; Do not edit! File generated at Wed Feb  1 21:57:10 2017