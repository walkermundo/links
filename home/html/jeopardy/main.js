context = {};

function document_ready(event)
{
	context.team1 = 0;
	context.team2 = 0;

	$('#team1Score').html(context.team1);
	$('#team2Score').html(context.team2);

	$('#btnTeam1').bind('click', btnTeam1_onclick);
	$('#btnTeam2').bind('click', btnTeam2_onclick);
	$('#btnTeam1Lose').bind('click', btnTeam1Lose_onclick);
	$('#btnTeam2Lose').bind('click', btnTeam2Lose_onclick);
	$('#btnSee').bind('click', btnSee_onclick);
	$('#btnStartFinal').bind('click', btnStartFile_onclick);
	$('#modalFinalCategories').bind('click', modalFinalCategories_onclick);
	$('#modalAnswer').bind('hidden.bs.modal', function (event)
	{
		if ($('.btn-answer:enabled').length == 0)
			$('#divFinal').removeClass('invisible');
	});

	var params = new URLSearchParams(location.search);
	context.option = params.get('option');

	if (context.option)
	{
		$.get(context.option + '.json', function (data)
		{
			var headerRow = $('#tableHeaderRow');
			var tableBody = $('#tableBody');

			var trs = [];

			data.categories.forEach(function (category)
			{
				headerRow.append('<th>' + category.name + '</th>');

				var y = 0;
				category.answers.forEach(function (obj)
				{
					if (!trs[y])
					{
						trs[y] = $('<tr>');
						trs[y].appendTo(tableBody);
					}

					var td = $('<td>');
					td.appendTo(trs[y]);

					var button = $('<button>');
					button.appendTo(td);
					button.attr('type', 'button');
					button.addClass('btn btn-block btn-primary text-warning btn-answer');
					button.attr('data-answer', obj.answer);
					button.attr('data-question', obj.question);
					button.text(obj.value);
					button.bind('click', button_onclick);
					y++;
				});
			});

			context.data = data;
		});
	}
}

function button_onclick(event)
{
	$('#answer').html($(this).attr('data-answer'));
	context.amount = +$(this).text();

	$(this).prop('disabled', true);
	$(this).removeClass('text-warning');
	$(this).addClass('text-primary');

	$('#question').html($(this).attr('data-question'));
	$('#question').hide();

	$('#modalAnswer').modal();
}

function btnTeam1_onclick(event)
{
	context.team1 += context.amount;
	update();

	$('#modalAnswer').modal('hide');
}

function btnTeam2_onclick(event)
{
	context.team2 += context.amount;
	update();

	$('#modalAnswer').modal('hide');
}

function btnTeam1Lose_onclick(event)
{
	context.team1 -= context.amount;
	update();
}

function btnTeam2Lose_onclick(event)
{
	context.team2 -= context.amount;
	update();
}

function btnSee_onclick(event)
{
	$('#question').show();
}

function btnStartFile_onclick(event)
{
	$('#adultCategory').html('Adults: ' + context.data.final.adults.category);
	$('#childCategory').html('Kids: ' + context.data.final.kids.category);
	$('#modalFinalCategories').modal('show');
}

function modalFinalCategories_onclick(event)
{
	if (context.data.final.showQuestion)
	{
		$('#adultCategory').html('Adults: ' + context.data.final.adults.question);
		$('#childCategory').html('Kids: ' + context.data.final.kids.question);
	}
	else
	{
		context.data.final.showQuestion = true;
		$('#adultCategory').html('Adults: ' + context.data.final.adults.answer);
		$('#childCategory').html('Kids: ' + context.data.final.kids.answer);
	}
}

function update()
{
	$('#team1Score').html(context.team1);
	$('#team2Score').html(context.team2);

	if (context.team1 > context.team2)
	{
		$('#team1Score').removeClass('text-danger');
		$('#team1Score').addClass('text-primary');

		$('#team2Score').addClass('text-danger');
		$('#team2Score').removeClass('text-primary');
	}
	else if (context.team2 > context.team1)
	{
		$('#team1Score').addClass('text-danger');
		$('#team1Score').removeClass('text-primary');

		$('#team2Score').removeClass('text-danger');
		$('#team2Score').addClass('text-primary');
	}
	else
	{
		$('#team1Score').removeClass('text-danger');
		$('#team1Score').removeClass('text-primary');
		$('#team2Score').removeClass('text-danger');
		$('#team2Score').removeClass('text-primary');
	}
}

$(document).ready(document_ready);