
% --- Blood group of donors and recipients

blood_group(saria, o_neg).
blood_group(tuku, a_pos).
blood_group(miad, b_pos).
blood_group(leon, ab_pos).
blood_group(istiak, o_pos).

% --- Age of donors
age(saria, 25).
age(tuku, 32).
age(miad, 40).
age(leon, 20).
age(istiak, 28).

% --- Weight of donors
weight(saria, 80).
weight(tuku, 48).  % Not valid
weight(miad, 70).
weight(leon, 55).
weight(istiak, 65).

% --- Health status
healthy(saria).
healthy(tuku).
healthy(miad).
healthy(leon).
healthy(istiak).

% --- Last donation in days (or never)
last_donated(saria, 120).
last_donated(tuku, 30).
last_donated(miad, never).
last_donated(leon, 95).
last_donated(istiak, 85).

% --- Availability of donors
available(saria).
available(miad).
available(leon).
available(istiak).

% --- Gender
gender(saria, female).
gender(tuku, female).
gender(miad, male).
gender(leon, male).
gender(istiak, male).

% --- Location
location(saria, dhaka).
location(tuku, dhaka).
location(miad, narayanganj).
location(leon, chittagong).
location(istiak, dhaka).

% --- Blood compatibility rules
can_donate(o_neg, a_pos).
can_donate(o_neg, b_pos).
can_donate(o_neg, ab_pos).
can_donate(o_neg, o_pos).
can_donate(o_pos, a_pos).
can_donate(o_pos, b_pos).
can_donate(o_pos, ab_pos).
can_donate(o_pos, o_pos).
can_donate(a_pos, ab_pos).
can_donate(a_pos, a_pos).
can_donate(a_neg, a_pos).
can_donate(b_pos, b_pos).
can_donate(b_pos, ab_pos).
can_donate(ab_pos, ab_pos).
can_donate(ab_neg, ab_pos).
can_donate(ab_neg, ab_neg).

% --- Validations
valid_age(X) :- age(X, A), A >= 18.
valid_weight(X) :- weight(X, W), W >= 50.
is_healthy(X) :- healthy(X).
can_donate_now(X) :- last_donated(X, never).
can_donate_now(X) :- last_donated(X, Days), Days >= 90.
same_city(X, Y) :- location(X, L), location(Y, L).

% --- Main rule: who can donate to whom
eligible_donor(Receiver, Donor) :-
    blood_group(Donor, DonorBG),
    blood_group(Receiver, ReceiverBG),
    can_donate(DonorBG, ReceiverBG),
    valid_age(Donor),
    valid_weight(Donor),
    is_healthy(Donor),
    can_donate_now(Donor),
    available(Donor),
    same_city(Donor, Receiver).
