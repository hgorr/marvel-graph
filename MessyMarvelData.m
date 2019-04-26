% Clean up and merge names, remove extras

%% Erase names in parens
Names = string(characterData.Character);
Names = regexprep(Names,"\((.+)\)","");
Names = strip(Names);

%% Exclude extra movie characters like "Security Guard #2"
characterData = subsetWithoutExtras(characterData,Names);

%% Merge multiple names into one name
characterData.Character = combineNames(characterData.Character);

% Remove empty categories
characterData.Character = removecats(characterData.Character);

%% Helper functions
function c = combineNames(c)
c =  mergecats(c,...
    ["Agent Coulson","Agent Phil Coulson","Phil Coulson"]);
c =  mergecats(c,...
    ["Bruce Banner / The Hulk","Bruce Banner","Bruce Banner / Hulk"]);
c =  mergecats(c,...
    ["Bucky Barnes / Winter Soldier","James Buchanan 'Bucky' Barnes"]);
c =  mergecats(c,...
    ["Carol Danvers / Captain Marvel","Carol Danvers / Vers / Captain Marvel",...
    "Carol Danvers"]);
c =  mergecats(c,...
    ["Dr. Strange","Doctor Strange", "Dr. Stephen Strange"],"Dr. Stephen Strange");
c =  mergecats(c,...
    ["Janet Van Dyne / The Wasp","Janet Van Dyne / Wasp","Janet Van Dyne"]);
c =  mergecats(c,...
    ["Hope Van Dyne / Wasp","Hope van Dyne","Hope van Dyne / The Wasp"]);
c =  mergecats(c,...
    ["Vision","Jarvis / Vision"]);  % Keep Jarvis separate from Vision
c =  mergecats(c,...
    ["Jarvis","JARVIS (voice)","Jarvis (voice)","JARVIS"],"Jarvis");
c =  mergecats(c,...
    ["James Rhodes / War Machine","Rhodey","Lt. Col. James 'Rhodey' Rhodes",...
    "Lieutenant James Rhodes / War Machine","Colonel James Rhodes"]);
c =  mergecats(c,...
    ["Natasha Romanoff / Black Widow","Natalie Rushman / Natasha Romanoff"]);
c =  mergecats(c,...
    ["Peter Quill / Star-Lord","Peter Quill"]);
c =  mergecats(c,...
    ["Red Skull","Johann Schmidt / Red Skull","Red Skull (Stonekeeper)"]);
c =  mergecats(c,...
    ["Tony Stark / Iron Man","Tony Stark"]);
c = mergecats(c,...
    ["Steve Rogers / Captain America","Captain America / Steve Rogers"]);
c =  mergecats(c,...
    ["Teen Groot","Teenage Groot Reader"]);
c =  mergecats(c,...
    ["Yondu", "Yondu Udonta"]);
c =  mergecats(c,...
    ["Cassie Lang","Cassie"]);
c =  mergecats(c,...
    ["Maggie Lang","Maggie"]);
c =  mergecats(c,...
    ["Dr. Hank Pym","Hank Pym"]);
c =  mergecats(c,...
    ["Kraglin / On Set Rocket","Kraglin / On-Set Rocket"]);
c =  mergecats(c,...
    ["Friday","Friday (voice)","Voice of Friday (voice)","Voice of Friday "]);
c =  mergecats(c,...
    ["Agent Sitwell","Agent Jasper Sitwell",...
    "Agent Sitwell (as Maximiliano Hernandez)","Jasper Sitwell (as Maximiliano Hernandez)"]);
c =  mergecats(c,...
    ["Brock Rumlow / Crossbones","Brock Rumlow"]);
end

function characterData = subsetWithoutExtras(characterData,Names)
% Remove unimportant characters from the list (no offense to the actors)
% (There are clever ways to do this based on text analytics, but since I was reading the list
% of characters anyway, I copied/pasted)
idx = contains(Names,...
    ["Helicopter","Security","Smithsonian","Johannesburg",...
    "70's","Bartender"," Driver","'s ","SHIELD"," Fan"," Boy","Store ",...
    " Teacher"," Instructor"," Narrator"," Officer","M.I.T."...
    " Employee","Truck ","AIM","Business","Oakland","Militant",...
    "Technician","Dispatcher","Car "]);
idx1 = endsWith(Names,...
    ["Kid","Tech","Cop","Student","Girl","Gangster",...
    "Passenger","Ambassador","Jerk","Ravager","Recruit",...
    "Therapist","Gambler","Singer","Child","Prisoner",...
    "Guard","Daughter","Doctor","Guy","Jogger",...
    "Surgeon","Reporter","Owner","Guide","Trucker"]);
idx2 = startsWith(Names,...
    ["Kid ","Woman ","Man ","Dealer","Cop","Drunk",...
    "Flight","Guard","Air Force","Handsome","Barman",...
    "Commando","Communications","Concerned", ...
    "Security","Large","Soldier","Boy ",...
    "Ironette", "S.H.I.E.L.D.","Street",...
    "HYDRA","Waitress","Faceless","Japanese","German",...
    "Gala","Maintenance","NASA","Laughing","Technical",...
    "Sleepy","Police","Student","Sad ","Engine","SHIELD",...
    "Sokovian","Armed","Bartender","Buyer","Ice Cream",...
    "Cab ","EMT","EMS","Gorgeous","Lab ","Barge ","Weird",...
    "Yelling","College","Asgardian","Nigerian","Mall ","Older",...
    "Surfer","Extremis","Frost Giant","Chinese",...
    "USO","Super Soldier","Annoy","BBC","Alien",...
    "AIM","AV","Accuser","Actor","Army","Asylum",...
    "Basketball","CIA","Celebration","Com ","Command ",...
    "Cop ","Delivery","Elderly","FBI","Expo ","FedEx",...
    "Ferry ","French ","Funeral","Golden","Head ","Hero ",...
    "Hospital","Hydra","MRI","Mandarin ","Female"...
    "Medic","Midtown","Milit","Museum","News",...
    "Nova ","Nurse","Pageant","Online","Pool ",...
    "President ","Pym Tech","Ravager","Reporter",...
    "Rose Hill","River","Rifle","San Francisco","Satellite",...
    "Scientist","Secret","Senior ","Sovereign","South ",...
    "Spanish","Stark ","Storage","Strike ","Superior",...
    "Support","Sweat ","Terrified","Robot","25th",...
    "Thai","Tourist","U.S.","UN","Viking","Waiter",...
    "Wench","Whale","World","Grand","Jabari","Navy ",...
    "Office","Lead","GSG9","Undercover","Xandarian","Valkyrie "]);
idx3 = ismember(Names,...
    ["'Adolph Hitler'","'Down There!'"]);
characterData.Character = categorical(Names);
characterData = characterData(~idx & ~idx1 & ~idx2 & ~idx3,:);

end