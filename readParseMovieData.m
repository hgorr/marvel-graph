function [movieData,characterData,Movie] = readParseMovieData(apikey)
% Read movie data with the OMDb API and character data from IMDb
% Example:
% [movieData,characterData,Movie] = readParseMovieData("1111");

% Get movie and character data for each movie
Movie = ["Iron Man";"The Incredible Hulk";"Iron Man 2";"Thor"; ...
    "Captain America: The First Avenger";"The Avengers";"Iron Man 3";  ...
    "Thor: The Dark World";"Captain America: The Winter Soldier";...
    "Guardians of the Galaxy";"Avengers: Age of Ultron";"Ant-Man";...
    "Captain America: Civil War";"Doctor Strange";"Guardians of the Galaxy Vol. 2";...
    "Spider-Man: Homecoming";"Thor: Ragnarok";"Black Panther";...
    "Avengers: Infinity War";"Ant-Man and the Wasp";"Captain Marvel";...
    "Avengers: Endgame"];
movieData = table;
characterData = table('Size',[1,2],'VariableTypes',{'string','string'},...
    'VariableNames',{'Character','Movie'});
for ii = 1:length(Movie)
    % Read movie data from OMDB API
    OMDbURL = "http://www.omdbapi.com/?t="+Movie(ii)+"&apikey="+apikey;
    opts = weboptions('Timeout',200);
    movieInfo = webread(OMDbURL,opts);
    % Convert to table and add movie info
    s = struct2table(movieInfo,'AsArray',true);
    s = convertvars(s,[1:14,16:25],'string');
    movieData = [movieData;s];                  %#ok
    % Read full character list from IMDb
    IMDbURL = "https://www.imdb.com/title/" + movieInfo.imdbID + ...
        "/fullcredits?ref_=tt_cl_sm#cast";
    w = webread(IMDbURL,opts);
    % Parse html to get the list of characters in movie
    w = string(extractBetween(w,'<td class="character">',"</td>"));
    w = eraseBetween(w,"<",">","Boundaries","inclusive");
    w = regexprep(w,"\s+"," ");
    w = strip(w);
    % Remove uncredited characters
    w = unique(w);
    Character = w(~contains(w,"(uncredited)"));
    tnew = table(Character,repmat(Movie(ii),size(Character)),...
        'VariableNames',{'Character','Movie'});
    characterData = [characterData;tnew];       %#ok
end

% Convert to categorical
characterData = convertvars(characterData,1:2,"categorical");
% Clean up names and remove some movie characters from the list
% For example, consider the following all the same name:
%["Bruce Banner / The Hulk","Bruce Banner","Bruce Banner / Hulk"]
MessyMarvelData

% Remove missing data
characterData = rmmissing(characterData);
characterData.Character = removecats(characterData.Character);

% Remove movie poster data if it exists (this data is only
% available to patrons
if any(movieData.Properties.VariableNames == "Poster")
    movieData = removevars(movieData,"Poster");
end
% Convert data types of movie data
movieData = convertvars(movieData,["Year","Metascore","imdbRating"],...
    "double");
movieData.Released = datetime(movieData.Released,"InputFormat","dd MMM uuuu"); 

end